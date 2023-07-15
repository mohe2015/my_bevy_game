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
          } rec {
            nativeBuildInputs = [
              pkgs.mold
              pkgs.nixpkgs-fmt
              pkgs.pkg-config
              pkgs.bashInteractive
            ];

            # https://github.com/bevyengine/bevy/blob/latest/docs/linux_dependencies.md#nix
            buildInputs = [
              pkgs.udev
              pkgs.alsa-lib
              pkgs.vulkan-loader

              # wayland
              pkgs.libxkbcommon
              pkgs.wayland
            ];

            LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath buildInputs;
          };
        }
      );
}
