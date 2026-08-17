{ pkgs, ... }: {

  programs.firefox = {
    enable = true;

    # Глобальный профиль
    policies = {
      ExtensionSettings = {
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/file/4872816/ublock_origin-1.72.0.xpi";
          installation_mode = "force_installed";
        };
        "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/file/4875950/bitwarden_password_manager-2026.6.1.xpi";
          installation_mode = "force_installed";
        };
        "jid1-MnnxcxisBPnSXQ@jetpack" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/file/4854040/privacy_badger17-2026.6.16.xpi";
          installation_mode = "force_installed";
        };
        "{036a55b4-5e72-4d05-a06c-cba2dfcc134a}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/file/4455681/traduzir_paginas_web-10.1.1.1.xpi";
          installation_mode = "force_installed";
        };
      };
    };
    
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
