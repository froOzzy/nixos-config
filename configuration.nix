{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./modules/fonts.nix
      ./modules/soft/keyd.nix
      ./modules/usb.nix
      ./modules/gc.nix
      ./home.nix
    ];

  # Boot loader
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
    systemd-boot = {
      enable = true;
      edk2-uefi-shell.enable = true;
    };
    grub = {
      enable = false;
    };
  };

  # Создание пользователя
  users.users."vladislav" = {
    isNormalUser = true;
    description = "Vladislav Dobrovolskiy";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      "electron-39.8.10"
    ];
  };

  home-manager = {
    backupFileExtension = "backup";
    useGlobalPkgs = true;
    useUserPackages = true;
  };

  networking = {
    hostName = "nixos";
    networkmanager = {
      enable = true;
      plugins = with pkgs; [
        networkmanager-openvpn
      ];
    };
  };

  # Set your time zone.
  time.timeZone = "Europe/Moscow";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ru_RU.UTF-8";
    LC_IDENTIFICATION = "ru_RU.UTF-8";
    LC_MEASUREMENT = "ru_RU.UTF-8";
    LC_MONETARY = "ru_RU.UTF-8";
    LC_NAME = "ru_RU.UTF-8";
    LC_NUMERIC = "ru_RU.UTF-8";
    LC_PAPER = "ru_RU.UTF-8";
    LC_TELEPHONE = "ru_RU.UTF-8";
    LC_TIME = "ru_RU.UTF-8";
  };

  i18n.supportedLocales = [
    "en_US.UTF-8/UTF-8"
    "ru_RU.UTF-8/UTF-8"
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    htop
    git
    usbutils
  ];

  system.stateVersion = "26.05";

  services.displayManager.cosmic-greeter.enable = true;
  services.desktopManager.cosmic.enable = true;
  services.system76-scheduler.enable = true;
  services.xserver.xkb = {
    layout = "us,ru";
    options = "";
  };
  console.useXkbConfig = true;

  # Поддержка nvidia
  services.xserver.videoDrivers = [ "nvidia" ];

  # Включаем Flatpack для магазина cosmic-store
  services.flatpak.enable = true;

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };

    nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };

  # Отключаем обновление sublime3
  networking.extraHosts = ''
    127.0.0.1 www.sublimetext.com
    127.0.0.1 sublimetext.com
  '';

  # Включаем Throne
  programs.throne = {
    enable = true;
    tunMode.enable = true;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nix.settings.substituters = [
     "https://mirror.sjtu.edu.cn/nix-channels/store"
     "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
     "https://mirrors.ustc.edu.cn/nix-channels/store"
  ];

  # Включаем systemctl для docker
  virtualisation.docker.enable = true;

  networking.firewall = {
    enable = true;
    checkReversePath = "loose";

    # Разрешаем входящие соединения со всех интерфейсов Docker и Docker Compose
    extraCommands = ''
      iptables -I INPUT 1 -i docker0 -j ACCEPT
      iptables -I INPUT 1 -i br-+ -j ACCEPT
    '';

  };  
}
