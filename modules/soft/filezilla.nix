{ config, pkgs, lib, ... }:

let
  bitwardenSshAuthSock = "${config.home.homeDirectory}/.bitwarden-ssh-agent.sock";

  filezilla-bw = pkgs.symlinkJoin {
    name = "filezilla-bitwarden-ssh";
    paths = [ pkgs.filezilla ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/filezilla \
        --set SSH_AUTH_SOCK "${bitwardenSshAuthSock}"
    '';
  };
in
{
  home.packages = [ filezilla-bw ];

  xdg.desktopEntries.filezilla = {
    name = "FileZilla";
    genericName = "FTP/SFTP client";
    comment = "FTP, FTPS and SFTP client";
    exec = "${filezilla-bw}/bin/filezilla %U";
    icon = "filezilla";
    terminal = false;
    categories = [ "Network" "FileTransfer" ];
    mimeType = [ "application/x-filezilla-config" ];
  };
}

