{ config, pkgs, ... }:

{
  # Подключение TP-Link Archer T3U
  boot.extraModulePackages = [ config.boot.kernelPackages.rtl88x2bu ];
  boot.kernelModules = [ "88x2bu" ];
  hardware.enableRedistributableFirmware = true;
}
