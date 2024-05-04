{
  description = "ayys's fork of st - the suckless simple terminal";

  inputs.nixpkgs.url = "nixpkgs/nixos-unstable";

  outputs =
    { self, nixpkgs }:
    let
      pkgs = import nixpkgs { system = "x86_64-linux"; };
    in
    {
      defaultPackage.x86_64-linux = pkgs.stdenv.mkDerivation {
        name = "st";
        src = ./.;
        buildInputs = [
          pkgs.gcc pkgs.pkg-config pkgs.xorg.libX11 pkgs.xorg.libXft
        ];
        buildPhase = ''
          make
        '';
        installPhase = ''
          mkdir -p $out/bin
          cp st $out/bin
        '';
      };

    };
}
