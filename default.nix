{}:

with import <nixpkgs> {};

stdenv.mkDerivation rec {

  version = "3.5.1219.4190";
  name = "tresorit-${version}";

  src = fetchurl {
    url = https://installer.tresorit.com/tresorit_installer.run;
    sha256 = "o0bYWUc3Bl6neZHgwwlKZJmQqqINskfNpiYTKLjy0sA=";
  };

  nativeBuildInputs = [ autoPatchelfHook ];
  buildInputs = [ qt5.qtbase
                  fuse ];

  dontBuild = true;
  dontConfigure = true;
  dontMake = true;
  dontWrapQtApps = true;

  unpackPhase  = ''
    tail -n+93 $src | tar xz -C $TMP
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp -rf $TMP/tresorit_x64/* $out/bin/
    rm $out/bin/uninstall.sh
  '';

  meta = with lib; {
    description = "Tresorit is the ultra-secure place in the cloud to store, sync and share files easily from anywhere, anytime.";
    homepage = https://tresorit.com;
    license = licenses.unfree;
    platforms = platforms.linux;
    maintainers = [ maintainers.apeyroux ];
  };
}
