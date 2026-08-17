{ config, pkgs, ... }:

let
  # Превращаем путь к текущей папке в сырую строку (абсолютный путь на диске)
  currentDir = builtins.toString ./.;
in

{
  # Включаем управление Neovim
  programs.neovim = {
    enable = true;
    defaultEditor = true;

    # Добавляем компилятор C и утилиту tree-sitter в окружение Neovim
    extraPackages = with pkgs; [
      gcc           # Предоставит нужный компилятор "cc" или "gcc"
      gnumake       # Часто нужен для сборки некоторых плагинов
      tree-sitter   # Поможет плагину nvim-treesitter работать стабильно
    ];
  };

  # Включаем XDG и линкуем соседнюю папку config в ~/.config/nvim
  xdg.enable = true;
  xdg.configFile."nvim" = {
    source = ./.;
    recursive = true;
  };
}
