{ pkgs, ... }:

{
  programs.niri.enable = true;
  services.displayManager.noctalia-greeter.enable = true;

  environment.systemPackages = with pkgs; [
    noctalia
    cosmic-files
    xwayland-satellite
  ];
}
