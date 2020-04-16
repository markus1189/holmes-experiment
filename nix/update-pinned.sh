#!/usr/bin/env nix-shell
#!nix-shell -i bash
#!nix-shell -p nix-prefetch-git -p cacert
#!nix-shell --pure

nix-prefetch-git https://github.com/nixos/nixpkgs-channels.git refs/heads/nixpkgs-unstable
