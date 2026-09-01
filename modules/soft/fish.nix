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
      set -gx SSH_AUTH_SOCK "$HOME/.bitwarden-ssh-agent.sock"

      # Загрузка алиасов
      if test -f ~/.config/fish/aliases.fish
          source ~/.config/fish/aliases.fish
      end
    '';
    shellAliases = {
      ssh = "env TERM=xterm-256color ssh";  
    };
  };
}
