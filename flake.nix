{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-21.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        ruby = pkgs.ruby_2_7;
        gems = pkgs.bundlerEnv {
          name = "pages-env";
          inherit ruby;
          gemdir = self;
        };
      in {
        devShell = pkgs.mkShell {
          buildInputs = [
            pkgs.bundix
            pkgs.bundler
            gems
          ];
        };
      });
}
