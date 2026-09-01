{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "froOzzy";
    userEmail = "development@osintforce.ru";

    extraConfig = {
      credential.helper = "store";
    };    
  };
}
