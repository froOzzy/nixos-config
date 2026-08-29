{ config, pkgs, ... }:

{
  programs.thunderbird.enable = true;

  # Прячем директорию, которую создает thunderbird из-за бага
  home.file.".hidden".text = ''
    thunderbird
  '';
}
