{ pkgs ? import <nixpkgs> {}, stdenv, callPackage }:

rec {
  grpc = callPackage ./pkgs/grpc {};
  protobuf3_3 = callPackage pkgs/protobuf/3.3.nix {};
  urho3d17 = callPackage pkgs/urho3d { withSamples = true; };
}
