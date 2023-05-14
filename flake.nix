{
  description = "Falling sand simulation written in Janet";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { self
    , nixpkgs
    , flake-utils
    }:

    flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs { inherit system; };
    in
    {
      devShells.default = pkgs.mkShell {
        packages = (with pkgs; [ janet jpm ]) ++
          pkgs.lib.optionals (pkgs.stdenv.isLinux) (with pkgs; []) ++ # Linux only
          pkgs.lib.optionals (pkgs.stdenv.isDarwin) (with pkgs; [ darwin.libobjc ]) ++ # macOS only
          (with pkgs.darwin.apple_sdk.frameworks; [
            AudioToolbox
            Carbon
            Cocoa
            CoreAudio
            Foundation
            IOKit
            Kernel
            OpenGL
          ]);

        shellHook = ''
        '';
      };
    });
}
