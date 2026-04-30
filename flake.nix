{
  description = "tadni/platform — Nix overlay for Coq packages";

  inputs.nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

  outputs = { self, nixpkgs }: let
    systems = [ "x86_64-linux" "aarch64-darwin" ];
    forAllSystems = nixpkgs.lib.genAttrs systems;
  in {

    overlays.default = import ./overlay.nix;

    packages = forAllSystems (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ self.overlays.default ];
        };
      in {
        coq-lens = pkgs.coqPackages_8_20.coq-lens;
      }
    );
  };
}
