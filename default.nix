{ ghcVersion ? "ghc8101" }:
let
  hostNixpkgs = import <nixpkgs> {};
  pinnedPkgsSet = hostNixpkgs.pkgs.lib.importJSON ./nix/nixpkgs-unstable.json;
  overlay = self: super: {
    myHaskellPackages = super.haskell.packages.${ghcVersion};
  };
  pinnedPkgs = hostNixpkgs.pkgs.fetchFromGitHub {
    owner = "NixOS";
    repo = "nixpkgs-channels";
    inherit (pinnedPkgsSet) rev sha256;
  };
  pkgs = import pinnedPkgs {
    overlays = [ overlay ];
  };
  src = (builtins.filterSource (path: type: type != "directory" || baseNameOf path != ".git") ./.);
  drv = pkgs.myHaskellPackages.callCabal2nix "holmes-experiment" src {};
in
  drv
