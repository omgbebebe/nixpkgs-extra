self: super:

let self = {
  grpc = self.extra.grpc;
  protobuf3_3 = self.extra.protobuf3_3;
  urho3d17 = self.extra.urho3d17;
  extra = super.callPackage ./default.nix {};
};
in self
