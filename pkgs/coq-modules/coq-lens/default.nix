{ lib, mkCoqDerivation, version ? null
, coq, metacoq-template-coq, metacoq-utils }:

with lib;

mkCoqDerivation {
  pname      = "lens";
  namePrefix = [ "coq" ];
  owner      = "tadni";
  repo       = "coq-lens";
  inherit version;

  defaultVersion = with versions; lib.switch coq.coq-version [
    { case = isEq  "8.20";        out = "1.0.5+8.20"; }
    { case = range "8.16" "8.19"; out = "1.0.4+8.16"; }
    { case = isEq  "8.15";        out = "1.0.3+8.15"; }
    { case = isEq  "8.14";        out = "1.0.2+8.14"; }
  ] null;

  release = {
    "1.0.5+8.20".rev    = "v1.0.5+8.20";
    "1.0.5+8.20".sha256 = "sha256-yHVxv5E5s2Ye9kLTz9fQexKOHFaf5hwkLTFlpXM54Ug=";
    "1.0.4+8.16".rev    = "v1.0.4+8.16";
    "1.0.4+8.16".sha256 = "sha256-nbDMvnIcdq5W29Yj/s63xTcVCrkjRCxJp7082ioYLCQ=";
    "1.0.3+8.15".rev    = "v1.0.3+8.15";
    "1.0.3+8.15".sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
    "1.0.2+8.14".rev    = "v1.0.2+8.14";
    "1.0.2+8.14".sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
  };

  # metacoq-template-coq is an OCaml plugin (.cmxs), so mlPlugin = true is
  # needed to make Coq's findlib aware of the plugin's OCaml package path.
  # Without this, coq_makefile-generated makefiles cannot load the plugin.
  mlPlugin = true;

  buildInputs           = [ metacoq-template-coq metacoq-utils ];
  propagatedBuildInputs = [ metacoq-template-coq metacoq-utils ];

  meta = {
    description = "Lenses for Coq record types, generated via MetaCoq Template";
    longDescription = ''
      coq-lens provides a first-order implementation of lenses in Coq.
      Lenses for any record type are generated automatically using
      MetaCoq's TemplateProgram metaprogramming facility. The resulting
      get/set record avoids the need for a Functor class and keeps
      type-checking simple.

      Note: lens generation requires records defined with
      Set Primitive Projections.

      The tadni/coq-lens fork adds compatibility with Coq 8.20 /
      MetaCoq 1.3.x, where utils and monad_utils moved from
      MetaCoq.Template to MetaCoq.Utils.
    '';
    homepage    = "https://github.com/tadni/coq-lens";
    license     = with lib.licenses; [ lgpl21Plus ];
    maintainers = [ ];
  };
}
