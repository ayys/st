{
  description = "ayys's fork of st - the suckless simple terminal";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    flakeutils.url = "github:numtide/flake-utils";
  };

  outputs =
    { self, nixpkgs, flakeutils }:
      flakeutils.lib.eachDefaultSystem (system:
        let pkgs = nixpkgs.legacyPackages.${system}; in
        {
          packages = rec {
            st = pkgs.stdenv.mkDerivation {
              name = "st";
              src = ./.;
              buildInputs = [
                pkgs.gcc pkgs.pkg-config pkgs.xorg.libX11 pkgs.xorg.libXft pkgs.ncurses pkgs.hack-font
              ];
              buildPhase = ''
          make
        '';
              installPhase = ''
          TERMINFO="$out" make install DESTDIR="$out" PREFIX=""
        '';
            };
            default = st;
          };
          apps = rec {
            st = flakeutils.lib.mkApp { drv = self.packages.${system}.st; };
            default = st;
          };
        }
      );
}
