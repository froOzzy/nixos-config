
{ pkgs, config, ... }:

{
  home-manager.users."vladislav" = { pkgs, ... }: {
    home.packages = with pkgs; [
      docker
      docker-compose
      bitwarden-desktop
      obsidian
      cosmic-store
      sublime3
      qbittorrent
      onlyoffice-desktopeditors
      telegram-desktop
      pre-commit
      k9s
      qwen-code
    ];

    imports = [
      ./modules/cosmic.nix
      ./modules/soft/alacritty.nix
      ./modules/soft/fish.nix
      ./modules/soft/firefox.nix
      ./modules/soft/nvim/neovim.nix
      ./modules/soft/pycharm.nix
      ./modules/soft/thunderbird.nix
      ./modules/soft/filezilla.nix
    ];

    home.sessionVariables = {
      SSH_AUTH_SOCK = "$HOME/.bitwarden-ssh-agent.sock";
    };

    systemd.user.sessionVariables = {
      SSH_AUTH_SOCK = "$HOME/.bitwarden-ssh-agent.sock";
    };

    home.stateVersion = "26.05";
  };
}
