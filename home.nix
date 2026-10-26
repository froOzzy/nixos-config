
{ pkgs, config, ... }:

{
  home-manager.users."vladislav" = { pkgs, ... }: {
    home.packages = with pkgs; [
      docker
      docker-compose
      bitwarden-desktop
      obsidian
      cosmic-store
      sublime3
      qbittorrent
      onlyoffice-desktopeditors
      telegram-desktop
      pre-commit
      kubectl
      k9s
      qwen-code
      uv
      unzip
      nodejs
      grim
      lazydocker
    ];

    imports = [
      ./modules/environment/cosmic/home.nix
      ./modules/environment/niri/home.nix
      ./modules/soft/alacritty.nix
      ./modules/soft/fish.nix
      ./modules/soft/firefox.nix
      ./modules/soft/nvim/neovim.nix
      ./modules/soft/pycharm.nix
      ./modules/soft/thunderbird.nix
      ./modules/soft/filezilla.nix
      ./modules/soft/screenshot.nix
    ];

    home.sessionVariables = {
      SSH_AUTH_SOCK = "$HOME/.bitwarden-ssh-agent.sock";
    };

    systemd.user.sessionVariables = {
      SSH_AUTH_SOCK = "$HOME/.bitwarden-ssh-agent.sock";
    };

    home.stateVersion = "26.05";
  };
}
