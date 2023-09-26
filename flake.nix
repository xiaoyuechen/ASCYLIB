{
  description = "A concurrent-search data-structure library";

  inputs.ssmem.url = "github:xiaoyuechen/ssmem";

  inputs.sspfd = {
    url = "github:trigonak/sspfd";
    flake = false;
  };

  inputs.raplread = {
    url = "github:LPD-EPFL/raplread";
    flake = false;
  };

  outputs = { self, nixpkgs, flake-utils, ssmem, sspfd, raplread, ... }:
    {
      overlays.default = final: prev: {
        ssmem = final.stdenv.mkDerivation {
          pname = "ssmem";
          version = "68f0dad";
          src = ssmem;
          installPhase = ''
            mkdir -p $out/include
            cp -r $src/include/*.h $out/include
            mkdir -p $out/lib
            cp libssmem.a $out/lib
          '';
        };

        sspfd = final.stdenv.mkDerivation {
          pname = "sspfd";
          version = "b65ff41";
          src = sspfd;
          installPhase = ''
            mkdir -p $out/include
            cp $src/sspfd.h $out/include
            mkdir -p $out/lib
            cp libsspfd.a $out/lib
          '';
        };

        raplread = final.stdenv.mkDerivation {
          pname = "raplread";
          version = " 0cf2378";
          src = raplread;
          installPhase = ''
            mkdir -p $out/include
            cp $src/rapl_read.h $out/include
            cp $src/platform_defs.h $out/include
            sed -i '49s/^/\/\//' $out/include/rapl_read.h
            sed -i '51s/^/\/\//' $out/include/rapl_read.h
            mkdir -p $out/lib
            cp libraplread.a $out/lib
          '';
        };
      };
    } //
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = import nixpkgs { inherit system; overlays = [ self.overlays.default ];
                                }; in
      {
        devShells.default = pkgs.callPackage ./shell.nix {};
        packages.default = pkgs.callPackage ./default.nix {};
      }
    );
}
