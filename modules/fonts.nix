{ config, pkgs, ... }:

{
  fonts.packages = with pkgs; [
    # Для lazyvim
    nerd-fonts.symbols-only
  ];
}
