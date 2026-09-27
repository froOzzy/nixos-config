{ config, pkgs, ... }:

let
  # Абсолютный путь к конфигу
  niriConfigPath = "/home/vladislav/.config/nixos-config/modules/desktops/niri/config.kdl";
in

{
  # Используем home.file вместо xdg.configFile, чтобы избежать ошибки '$HOME'
  home.file.".config/niri/config.kdl" = {
    source = config.lib.file.mkOutOfStoreSymlink niriConfigPath;
  };

  # Курсор
  home.pointerCursor = {
    enable = true;
    gtk.enable = true;
    
    package = pkgs.pop-icon-theme;
    name = "Pop";
    size = 24;
  };

  gtk = {
    enable = true;
  };
}
