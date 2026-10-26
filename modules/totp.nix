{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    google-authenticator
  ];

  # Экран входа Noctalia Greeter использует greetd.
  # Собственный стек PAM не зависит от настройки login для блокировки экрана.
  # security.pam.services.greetd = {
  #   useDefaultRules = lib.mkForce true;
  #   startSession = true;
  #   lastlog = config.security.pam.services.login.lastlog;
  #   rules = {
  #     # Заменяем делегирование в login стандартными правилами этого сервиса.
  #     auth.login.enable = false;
  #     account.login.enable = false;
  #     password.login.enable = false;
  #     session.login.enable = false;
  #
  #     auth.unix-early.enable = lib.mkForce false;
  #     auth.unix.settings = {
  #       try_first_pass = lib.mkForce false;
  #       use_first_pass = true;
  #     };
  #     auth.gnome_keyring.order =
  #       config.security.pam.services.greetd.rules.auth.google_authenticator.order + 10;
  #   };
  #   enableGnomeKeyring = config.security.pam.services.login.enableGnomeKeyring;
  #   googleAuthenticator = {
  #     enable = true;
  #     allowNullOTP = false;
  #     forwardPass = true;
  #   };
  # };

  # Noctalia использует PAM-сервис login и одно поле ввода.
  # Ввод: пароль сразу за ним текущий шестизначный TOTP, без разделителя.
  # security.pam.services.login = {
  #   googleAuthenticator = {
  #     enable = true;
  #     allowNullOTP = false;
  #     forwardPass = true;
  #   };
  #
  #   # Сначала Google Authenticator отделяет код и сохраняет пароль в PAM_AUTHTOK.
  #   # Не проверяем объединённую строку как обычный пароль до этого шага.
  #   rules.auth.unix-early.enable = lib.mkForce false;
  #   # Связка ключей должна получить уже выделенный пароль, без TOTP.
  #   rules.auth.gnome_keyring.order =
  #     config.security.pam.services.login.rules.auth.google_authenticator.order + 10;
  #   rules.auth.unix.settings = {
  #     try_first_pass = lib.mkForce false;
  #     use_first_pass = true;
  #   };
  # };
}
