final: prev:
let
  extendCoqPackages = coqPackages:
    coqPackages.overrideScope (_: _:
      import ./pkgs/coq-modules coqPackages
    );
  python3 = prev.python3.override {
    packageOverrides = _: pyPrev: {
      pytanque = pyPrev.buildPythonPackage {
        pname = "pytanque";
        version = "0.2.2";
        pyproject = true;

        src = prev.fetchFromGitHub {
          owner = "LLM4Rocq";
          repo = "pytanque";
          rev = "v0.2.2";
          hash = "sha256-1Hae21BuMdE6MjRdiBO7fcsuS4HzahOdLLhynAUox3I=";
        };

        build-system = [ pyPrev.setuptools ];

        dependencies = with pyPrev; [
          typing-extensions
          requests
        ];
      };
    };
  };
in {
  inherit python3;
  python3Packages = python3.pkgs;
  coqPackages_8_20 = extendCoqPackages prev.coqPackages_8_20;
  coqPackages_8_19 = extendCoqPackages prev.coqPackages_8_19;
  coqPackages_8_18 = extendCoqPackages prev.coqPackages_8_18;
  coqPackages_8_16 = extendCoqPackages prev.coqPackages_8_16;
  rocq-mcp = final.callPackage ./pkgs/rocq-mcp.nix {};
}
