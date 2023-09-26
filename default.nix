{ stdenv
, ssmem
, sspfd
, raplread
}:

stdenv.mkDerivation {
  pname = "ASCYLIB";
  version = "3c2d1a2";
  src = ./.;
  buildInputs = [ ssmem sspfd raplread ];
  installPhase = ''
    mkdir -p $out/bin
    cp -r bin/. $out/bin
  '';
}
