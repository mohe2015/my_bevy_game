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
            ];

            buildInputs = [
              # https://github.com/bevyengine/bevy/blob/latest/docs/linux_dependencies.md
              pkgs.alsaLib
              pkgs.udev
              pkgs.wayland
              pkgs.libxkbcommon # needed otherwise winit will crash
              pkgs.vulkan-loader
            ];

            shellInputs = buildInputs;
            shellHook = ''
              export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:${pkgs.lib.makeLibraryPath buildInputs}"
            '';
          };
        }
      );
}
