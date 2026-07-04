{ pkgs, ... }: {

  programs.firefox = {
    enable = true;

    # Создание пользовательского профиля
    profiles.default = {
      name = "Default";
      isDefault = true;

      settings = {
        "browser.startup.homepage" = "https://google.com";
        "browser.search.region" = "RU";
        "browser.search.isUS" = false;
        "browser.startup.page" = 3;
        
        # Приватность и телеметрия
        "datareporting.healthreport.uploadEnabled" = false;
        "browser.ping-centre.telemetry" = false;
        "privacy.trackingprotection.enabled" = true;
        
        # Оптимизация под Wayland / Hyprland
        "gfx.webrender.all" = true;
        "widget.wayland.opaque-move-resize.enabled" = true;
      };

      # Настройка поисковых систем по умолчанию
      search = {
        force = true;
        default = "google";
        order = [ "google"  "ddg" ];
      };
    };
  };
}
