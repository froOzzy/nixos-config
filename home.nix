{ config, pkgs, lib, ... }:

{
  # Создание пользователя
  users.users."vladislav" = {
    isNormalUser = true;
    description = "Vladislav Dobrovolskiy";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # Конфигурация Home-Manager
  home-manager.users."vladislav" = { pkgs, ... }: {
    home.packages = with pkgs; [
      docker
      docker-compose
      flameshot
    ];

    imports = [
      ./modules/cosmic.nix
      ./modules/soft/alacritty.nix
      ./modules/soft/fish.nix
      ./modules/soft/firefox.nix
      ./modules/soft/nvim/neovim.nix
    ];

    programs.bash.enable = true;
    home.stateVersion = "26.05";
  };
 
}
