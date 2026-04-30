final: prev:
let
  extendCoqPackages = coqPackages:
    coqPackages.overrideScope (_: _:
      import ./pkgs/coq-modules coqPackages
    );
in {
  coqPackages_8_20 = extendCoqPackages prev.coqPackages_8_20;
  coqPackages_8_19 = extendCoqPackages prev.coqPackages_8_19;
  coqPackages_8_18 = extendCoqPackages prev.coqPackages_8_18;
  coqPackages_8_16 = extendCoqPackages prev.coqPackages_8_16;
}
