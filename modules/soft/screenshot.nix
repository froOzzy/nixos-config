{ pkgs, ... }:

{
  home.packages = with pkgs; [
    grim          # Захват экрана
    slurp         # Выделение области
    satty         # Редактор скриншотов
    wl-clipboard  # Буфер обмена Wayland
  ];
}
