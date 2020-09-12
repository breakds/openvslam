let pkgs = import <nixpkgs> {
      config.allowUnfree = true;
    };

    customizedOpencv4 = pkgs.opencv4.override {
      enableGtk3 = true;
      enableFfmpeg = true;
      enableGStreamer = true;
    };

    libDBoW2 = pkgs.callPackage ./nix/DBoW2.nix {
      opencv = customizedOpencv4;
    };
    libpopl = pkgs.callPackage ./nix/popl.nix {};

in pkgs.mkShell rec {
  name = "osm";
  buildInputs = with pkgs; [
    cmake
    cmakeCurses
    pkgconfig

    nlohmann_json
    libGLU
    spdlog
    eigen # >= 3.3
    libyamlcpp
    customizedOpencv4
    suitesparse
    g2o
    libDBoW2
    libpopl
    openblas
    pangolin

    gperftools
  ];
  shellHook = ''
    export PS1="$(echo -e '\uf277') {\[$(tput sgr0)\]\[\033[38;5;228m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\]} (${name}) \\$ \[$(tput sgr0)\]"
    export CC=clang
    export CXX=clang++
  '';
}
