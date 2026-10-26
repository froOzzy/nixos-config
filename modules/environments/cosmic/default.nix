{ pkgs, ... }:

{
  environment.systemPackages = [ pkgs.keyd ];

  services.desktopManager.cosmic.enable = true;
  services.displayManager.cosmic-greeter.enable = true;
  services.system76-scheduler.enable = true;

  environment.systemPackages = with pkgs; [
    cosmic-store
  ];

  # Включаем Flatpack для магазина cosmic-store
  services.flatpak.enable = true;

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

