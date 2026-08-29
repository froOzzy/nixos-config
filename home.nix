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
      onlyoffice-desktopeditors
      filezilla
      telegram-desktop
      pre-commit
      k9s
    ];

    imports = [
      ./modules/cosmic.nix
      ./modules/soft/alacritty.nix
      ./modules/soft/fish.nix
      ./modules/soft/firefox.nix
      ./modules/soft/nvim/neovim.nix
      ./modules/soft/pycharm.nix
      ./modules/soft/thunderbird.nix
    ];

    xdg.configFile."environment.d/10-ssh-auth-sock.conf".text = ''
      SSH_AUTH_SOCK=%h/.bitwarden-ssh-agent.sock
    '';

    home.stateVersion = "26.05";
  };
}
