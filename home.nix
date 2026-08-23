{ pkgs, ... }:

{
  home-manager.users."vladislav" = { pkgs, ... }: {
    home.packages = with pkgs; [
      docker
      docker-compose
      flameshot
      bitwarden-desktop
      obsidian
      cosmic-store
      sublime3
      qbittorrent
      telegram-desktop
    ];

    imports = [
      ./modules/cosmic.nix
      ./modules/soft/alacritty.nix
      ./modules/soft/fish.nix
      ./modules/soft/firefox.nix
      ./modules/soft/nvim/neovim.nix
      ./modules/soft/pycharm.nix
    ];

    programs.bash = {
      enable = true;
      initExtra = ''
        export SSH_AUTH_SOCK="$HOME/.bitwarden-ssh-agent.sock"
      '';
    };

    home.stateVersion = "26.05";
  };
}
