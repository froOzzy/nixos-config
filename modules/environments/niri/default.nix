{ pkgs, ... }:

{
  programs.niri.enable = true;
  services.displayManager.noctalia-greeter = {
    enable = true;

    settings = {
      keyboard.layout = "us,ru";
      keyboard.options = "grp:caps_toggle";
    };
  };

  environment.systemPackages = with pkgs; [
    noctalia
    cosmic-files
  ];
}
