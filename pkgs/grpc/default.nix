{ pkgs, stdenv, lib, fetchgit, autoconf, automake, libtool, which, zlib, openssl, pkgconfig
}:

stdenv.mkDerivation rec {
  name    = "grpc-${version}";
  version = "1.4.6-${lib.strings.substring 0 7 rev}";
  rev     = "d006cbc2edcc9d5d33ed229162adb6cfcaf327e6";
  src = fetchgit {
    inherit rev;
    url    = "https://github.com/grpc/grpc.git";
    sha256 = "0h8bg2wv499cfw4r1n7b5xcnlfrgsd8sb5m46zpsn3v90677x5ad";
  };

  preBuild = ''
    sed -i "s|/usr/local|$out|" Makefile
  '';
  postInstall = ''
    pushd $out/lib
    for f in *.so.4; do
      ln -sf $(basename $f) $(basename $f .4).1
    done
    popd
  '';

#  preInstall  = "export prefix=$out";
  buildInputs =
    (if stdenv.isDarwin then [ pkgs.darwin.cctools ] else []) ++ [
    autoconf
    automake
    libtool
    which
    zlib
    openssl
    pkgconfig
  ];
}
