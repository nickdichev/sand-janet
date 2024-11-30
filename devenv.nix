{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:

let
  darwin_pks = with pkgs.darwin.apple_sdk.frameworks; [
    AudioToolbox
    Cocoa
    Carbon
    CoreAudio
    Foundation
    IOKit
    Kernel
    OpenGL
  ];
in
{
  packages =
    with pkgs;
    [
      janet
      jpm
    ]
    ++ lib.optionals stdenv.isDarwin darwin_pks;
}
