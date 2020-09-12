{ stdenv, cmake, fetchFromGitHub, opencv, eigen }:

stdenv.mkDerivation rec {
  pname = "DBoW2";
  version = "1.1";
  
  src = fetchFromGitHub {
    owner = "shinsumicco";
    repo = "DBoW2";
    sha256 = "0wfq3b6l1anqaxzmg5qdkfw6wjg97x8q6f2y0d8vhzpvf484qvbw";
    rev = "e8cc74d24705d0ad61b68df4e1086d1deff67136";
  };

  nativeBuildInputs = [ cmake ];
  buildInputs = [ opencv eigen ];

  meta = with stdenv.lib; {
    homepage = "https://github.com/shinsumicco/DBoW2";
    description = ''
      An open source C++ library for indexing and converting images into 
      a bag-of-word representation.
    '';
    platforms = with platforms; linux ++ darwin;
    licencse = licenses.bsd;
  };
}
