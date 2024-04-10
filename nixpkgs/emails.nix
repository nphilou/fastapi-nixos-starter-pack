{ lib
, buildPythonPackage
, fetchPypi
, premailer
, python-dateutil
, chardet
}:

buildPythonPackage rec {
  pname = "emails";
  version = "0.6";

  src = fetchPypi {
    inherit pname version;
    sha256 = "a4c2d67ea8b8831967a750d8edc6e77040d7693143fe280e6d2a367d9c36ff88";
  };

  doCheck = false;

  propagatedBuildInputs = [
    premailer
    python-dateutil
    chardet
  ];
}