{ config, pkgs, ... }:

{
  # Включаем управление Neovim
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  # Включаем XDG и линкуем соседнюю папку config в ~/.config/nvim
  xdg.enable = true;
  xdg.configFile."nvim" = {
    source = ./.;
    recursive = true;
  };
}
