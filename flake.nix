{
  description = "Lightning Gacha — Japan RepRap Festival 2026";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      perSystem = { pkgs, ... }:
        let
          # Bundle the fonts used by both EN and JA handouts and point typst
          # at the resulting directory.
          fonts = pkgs.symlinkJoin {
            name = "lightning-gacha-fonts";
            paths = [
              pkgs.source-han-sans
              pkgs.roboto
              pkgs.nerd-fonts.hack
            ];
          };
        in
        {
          # `nix develop` — drop into a shell with everything `handout/build.sh`
          # needs. Run the script from inside this shell.
          devShells.default = pkgs.mkShell {
            packages = with pkgs; [
              typst
              openscad-unstable
              imagemagick
              qrencode
            ];

            shellHook = ''
              export TYPST_FONT_PATHS=${fonts}
            '';
          };
        };
    };
}
