{
  description = "my bevy game";

  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let pkgs = nixpkgs.legacyPackages.${system}; in
        {
          devShells.default = pkgs.mkShell.override {
            stdenv = pkgs.llvmPackages_latest.stdenv;
          } {
            nativeBuildInputs = [
              pkgs.mold
              pkgs.nixpkgs-fmt
              pkgs.pkg-config
            ];

            buildInputs = [
              pkgs.alsa-lib
              pkgs.udev
            ];
          };
        }
      );
}