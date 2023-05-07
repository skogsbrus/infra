{
  description = "Flake for developer & CI/CD environments for cloud infrastructure";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        lib = nixpkgs.lib;
        runtimeDeps = with pkgs; [ bash terraform ];
        installDeps = with pkgs; [ makeWrapper ];
      in
      rec
      {
        devShell = pkgs.mkShell {
          packages = runtimeDeps;
        };

        packages.ci = pkgs.stdenv.mkDerivation {
          name = "ci";

          nativeBuildInputs = installDeps;
          buildInputs = runtimeDeps;

          src = ./ci;

          # Skip the other phases
          phases = [
            "installPhase"
          ];

          # Install our CI/CD bash script, wrapped to get visibility of its
          # dependencies' paths.
          installPhase = ''
            mkdir -p $out/bin
            install -t $out/bin $src/ci.sh
            wrapProgram $out/bin/ci.sh \
              --prefix PATH : ${lib.makeBinPath runtimeDeps}
          '';
        };

        defaultPackage = packages.ci;
      }
    );
}
