{ pkgs, ... }:

{
  programs.fish = {
    enable = true;

    plugins = [
      {
        name = "boxfish";
        src = pkgs.fetchFromGitHub {
          owner = "joelwanner";
          repo = "theme-boxfish";
          rev = "7c448cef4c61e7b66e8f57afd14c6a6764b19dc7";
          sha256 = "sha256-vW5qE9WQhG7gQE1SHCksj0wNm324GwvGaTBGKMyIJuk=";
        };
      }
    ];

    interactiveShellInit = ''
      set fish_greeting ""
    '';
  };
}
