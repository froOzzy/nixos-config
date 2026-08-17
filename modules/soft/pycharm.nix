{ pkgs, ... }:

let
  pycharm = pkgs.stdenv.mkDerivation rec {
    pname = "jetbrains-pycharm";
    version = "2025.2.6.2";

    src = pkgs.fetchurl {
      url = "https://download.jetbrains.com/python/pycharm-2025.2.6.2.tar.gz";
      hash = "sha256-AddEEEBpTsaYKtGqyX9vX+e8Uv2IsAq2dI85PcOqXXg=";
    };

    nativeBuildInputs = [ pkgs.autoPatchelfHook pkgs.makeWrapper ];
    buildInputs = [
      pkgs.jetbrains.jdk
      pkgs.zlib
      pkgs.glib
      pkgs.glibc
      pkgs.libxcrypt
      pkgs.musl
      pkgs.libX11
      pkgs.libXi
      pkgs.libXrender
      pkgs.freetype
      pkgs.alsa-lib
      pkgs.libXtst
      pkgs.linux-pam
      pkgs.cups
      pkgs.e2fsprogs.out
    ];

    runtimeDependencies = [ pkgs.e2fsprogs.out ];

    installPhase = ''
      mkdir -p $out/share
      cp -r . $out/share
      rm -r $out/share/jbr

      mkdir -p $out/lib
      ln -s ${pkgs.e2fsprogs.out}/lib/libe2p.so* $out/lib/

      makeWrapper \
        $out/share/bin/pycharm.sh \
        $out/bin/jetbrains-pycharm \
        --prefix LD_LIBRARY_PATH : "$out/lib:${pkgs.e2fsprogs.out}/lib" \
        --set PYCHARM_JDK "${pkgs.jetbrains.jdk}" \
        --set JAVA_HOME "${pkgs.jetbrains.jdk}" \
        --set JDK_HOME "${pkgs.jetbrains.jdk}" \
        --set GATEWAY_JDK "${pkgs.jdk}" \
        --set JETBRAINSCLIENT_JDK "${pkgs.jetbrains.jdk.home}"
    '';
  };

  pycharm-desktop = pkgs.makeDesktopItem {
    name = "jetbrains-pycharm";
    desktopName = "PyCharm Professional";
    exec = "${pycharm}/bin/jetbrains-pycharm";
    icon = "${pycharm}/share/bin/pycharm.svg";
    comment = "Python IDE for Professional Developers";
    categories = [ "Development" "IDE" ];
    terminal = false;
  };
in
{
  home.packages = [
    pycharm
    pycharm-desktop
  ];
}
