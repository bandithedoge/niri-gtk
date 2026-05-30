{
  outputs = {
    self,
    nixpkgs,
  }: let
    forAllSystems = nixpkgs.lib.genAttrs ["x86_64-linux" "aarch64-linux"];
  in {
    packages = forAllSystems (system: let
      pkgs = nixpkgs.legacyPackages.${system};
      mkPkg = src:
        import src {
          inherit self pkgs;
          mkAstalPkg = import ./nix/mkAstalPkg.nix pkgs;
        };
    in {
      default = self.packages.${system}.io;
      niri = mkPkg ./src;
    });

    devShells = forAllSystems (system:
      import ./nix/devshell.nix {
        inherit self;
        pkgs = nixpkgs.legacyPackages.${system};
      });
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };
}
