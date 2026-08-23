{ config, pkgs, ... }:

{
  progrmas.thunderbird.enable = true;

  # Прячем директорию, которую создает thunderbird из-за бага
  home.file.".hidden".text = ''
    thunderbird
  '';
}
