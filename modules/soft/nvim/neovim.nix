{ config, pkgs, ... }:

let
  # Абсолютный путь к исходникам
  nvimConfigDir = "/home/vladislav/.config/nixos-config/modules/soft/nvim";
in

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;

    sideloadInitLua = true;

    extraPackages = with pkgs; [
      gcc
      gnumake
      tree-sitter
      pyright
      ripgrep
      fd
      lua-language-server
      stylua
      git
      lazygit
    ];
  };

  # Используем home.file вместо xdg.configFile, чтобы избежать ошибки '$HOME'
  home.file.".config/nvim" = {
    source = config.lib.file.mkOutOfStoreSymlink nvimConfigDir;
  };
}
