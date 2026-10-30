{ config, pkgs, ... }:

let
  defaultWorkspace = "${config.home.homeDirectory}/Documents/Skills";

  tools = pkgs.buildEnv {
    name = "codex-isolated-tools";

    paths = with pkgs; [
      codex
      bashInteractive
      coreutils
      findutils
      gnugrep
      gnused
      gawk
      git
      ripgrep
      cacert

      # Дополнительные инструменты:
      # nodejs
      # python3
    ];
  };

  # Только необходимые пакеты и их зависимости.
  closure = pkgs.closureInfo {
    rootPaths = [ tools ];
  };

  launcher = pkgs.writeShellApplication {
    name = "codex-isolated";
    runtimeInputs = [ pkgs.coreutils ];
    inheritPath = false;

    excludeShellChecks = [ "SC2016" ];

    text = ''
      workspace=${pkgs.lib.escapeShellArg defaultWorkspace}

      # Параметр внешней песочницы должен идти первым.
      if [[ "''${1:-}" == "--workspace" ]]; then
        if [[ $# -lt 2 || -z "$2" ]]; then
          echo "Использование: codex-isolated --workspace ПАПКА [аргументы Codex]" >&2
          exit 1
        fi

        workspace=$2
        shift 2
      fi

      if [[ ! -d "$workspace" ]]; then
        echo "Рабочая папка не существует: $workspace" >&2
        exit 1
      fi

      workspace=$(realpath -e -- "$workspace")
      host_home=$(realpath -e -- ${pkgs.lib.escapeShellArg config.home.homeDirectory})

      case "$workspace" in
        /|/home|"$host_home"|/etc|/etc/*|/nix|/nix/*|\
        /proc|/proc/*|/sys|/sys/*|/dev|/dev/*|\
        /run|/run/*|/usr|/usr/*|/bin|/bin/*|\
        /sbin|/sbin/*|/lib|/lib/*|/lib64|/lib64/*)
          echo "Выберите отдельную рабочую папку вместо системного каталога или всего HOME." >&2
          exit 1
          ;;
      esac

      args=(
        --unshare-all
        --share-net
        --die-with-parent
        --new-session
        --cap-drop ALL
        --clearenv

        --proc /proc
        --dev /dev
        --tmpfs /tmp
        --tmpfs /run
        --dir /etc
        --dir /bin
        --dir /usr/bin

        # Единственное подключение файлов хоста на запись.
        --bind "$workspace" /workspace
        --chdir /workspace

        --symlink ${tools} /tools
        --symlink ${pkgs.bashInteractive}/bin/bash /bin/bash
        --symlink /bin/bash /bin/sh
        --symlink ${pkgs.coreutils}/bin/env /usr/bin/env

        --setenv PATH /tools/bin
        --setenv HOME /workspace/.codex-home
        --setenv CODEX_HOME /workspace/.codex-home/.codex
        --setenv XDG_CONFIG_HOME /workspace/.codex-home/.config
        --setenv XDG_CACHE_HOME /workspace/.codex-home/.cache
        --setenv XDG_DATA_HOME /workspace/.codex-home/.local/share
        --setenv SHELL /bin/bash
        --setenv USER agent
        --setenv LOGNAME agent
        --setenv LANG C.UTF-8
        --setenv TERM "''${TERM:-xterm-256color}"
        --setenv SSL_CERT_FILE ${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt
        --setenv GIT_SSL_CAINFO ${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt
      )

      # Подключаем инструменты и библиотеки только на чтение.
      while IFS= read -r store_path; do
        args+=(--ro-bind "$store_path" "$store_path")
      done < ${closure}/store-paths

      # Разрешение имён для доступа к интернету.
      for file in /etc/resolv.conf /etc/hosts; do
        if [[ -e "$file" ]]; then
          args+=(--ro-bind "$file" "$file")
        fi
      done

      # Корень read-only; отдельные writable mounts сохраняются.
      args+=(--remount-ro /)

      command=(/tools/bin/codex "$@")

      # Диагностическая оболочка внутри той же песочницы.
      if [[ "''${1:-}" == "--shell" ]]; then
        shift
        command=(/bin/bash --noprofile --norc "$@")
      fi

      exec ${pkgs.bubblewrap}/bin/bwrap "''${args[@]}" -- \
        /bin/bash --noprofile --norc -c '
          umask 077
          mkdir -p "$HOME" "$CODEX_HOME"
          exec "$@"
        ' sandbox "''${command[@]}"
    '';
  };
in
{
  home.packages = [ launcher ];
}
