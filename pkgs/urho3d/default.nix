{ fetchurl, stdenv, lib, cmake, pkgconfig
, x11Support ? true, libICE, libXi, libXScrnSaver, libXcursor, libXinerama, libXext, libXxf86vm, libXrandr
, alsaSupport ? true, alsaLib
, pulseaudioSupport ? true, libpulseaudio
, openglSupport ? true, mesa_noglu
, withSamples ? false
}:

stdenv.mkDerivation rec {
  name = "urho3d";
  version = "1.7";

  src = fetchurl {
      url = "https://github.com/urho3d/Urho3D/archive/${version}.tar.gz";
      sha256 = "1im63n9rx8qq1ks6aq6jrl5ikxg87hqhsy06miqc317hpm1iyav5";
  };

  cmakeFlags = [ "-DURHO3D_PCH=0" ];
#    ++ map (x: "-DOGRE_BUILD_PLUGIN_${x}=on")
#           ([ "BSP" "OCTREE" "PCZ" "PFX" ] ++ lib.optional withNvidiaCg "CG")
#    ++ map (x: "-DOGRE_BUILD_RENDERSYSTEM_${x}=on") [ "GL" ];

  enableParallelBuilding = false;

  propagatedBuildInputs = lib.optionals x11Support [ libICE libXi libXScrnSaver libXcursor libXinerama libXext libXrandr libXxf86vm ] ++
    lib.optional pulseaudioSupport libpulseaudio;

  buildInputs = [ cmake ] ++
    lib.optional openglSupport mesa_noglu ++
    lib.optional alsaSupport alsaLib;
    
#   ] ++ lib.optional withNvidiaCg nvidia_cg_toolkit;

  meta = {
    description = "Urho3D is a cross-platform 2D and 3D game engine";
    homepage = https://urho3d.github.io/;
    maintainers = [ ];
    platforms = stdenv.lib.platforms.linux;
    license = stdenv.lib.licenses.mit;
  };
}
