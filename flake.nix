{
  description = "Flake for developer & CI/CD environments";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        lib = nixpkgs.lib;
        buildInputs = with pkgs; [ bash terraform ];
      in
      rec
      {
        devShell = pkgs.mkShell {
          packages = buildInputs;
        };

        packages.ci = pkgs.stdenv.mkDerivation {
          name = "ci";
          nativeBuildInputs = with pkgs; [ makeWrapper ];
          buildInputs = buildInputs;
          src = ./ci;
          phases = [
            "installPhase"
          ];

          # TODO: wrapper with dependencies?
          installPhase = ''
            mkdir -p $out/bin
            install -t $out/bin $src/ci.sh
            wrapProgram $out/bin/ci.sh \
              --prefix PATH : ${lib.makeBinPath buildInputs}
          '';
        };

        defaultPackage = packages.ci;
      }
    );
}
