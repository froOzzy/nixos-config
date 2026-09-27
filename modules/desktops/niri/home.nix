{ config, pkgs, ... }:

let
  # Абсолютный путь к конфигу
  niriConfigPath = "/home/vladislav/.config/nixos-config/modules/desktops/niri/config.kdl";
  noctaliaConfigPath = "/home/vladislav/.config/nixos-config/modules/desktops/niri/config.toml";
in

{
  # Используем home.file вместо xdg.configFile, чтобы избежать ошибки '$HOME'
  home.file.".config/niri/config.kdl" = {
    source = config.lib.file.mkOutOfStoreSymlink niriConfigPath;
  };

  home.file.".config/noctalia/config.toml" = {
    source = config.lib.file.mkOutOfStoreSymlink noctaliaConfigPath;
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
