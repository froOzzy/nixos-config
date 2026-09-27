{ pkgs, ... }:

{
  programs.niri.enable = true;
  services.displayManager.cosmic-greeter.enable = true;

  environment.systemPackages = with pkgs; [
    noctalia
    cosmic-files
  ];
}
