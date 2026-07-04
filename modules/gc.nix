{ config, pkgs, ... }:

{
  nix = {
    # Настройки сборщика мусора
    gc = {
      automatic = true;
      dates = "daily";
      
      # Удаляем все поколения системы и Home Manager старше 14 дней
      options = "--delete-older-than 14d";
    };

    # Оптимизация диска (заменяет дубликаты файлов жесткими ссылками)
    settings.auto-optimise-store = true;
  };
}
