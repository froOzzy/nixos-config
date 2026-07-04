{ config, pkgs, ... }:

{
  
  environment.systemPackages = [ pkgs.keyd ];
  
  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        ids = [ "*" ];
        settings = {
          main = {
            # Одиночное нажатие генерирует макрос Meta + Space для COSMIC
            capslock = "macro(leftmeta+space)";
          };
          shift = {
            # Shift + Caps Lock сохраняет стандартную функцию включения заглавных букв
            capslock = "capslock";
          };
        };
      };
    };
  };
}
