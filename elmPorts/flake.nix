{
  description = "Simple elm + ports flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
  };

  outputs =
    { nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = [
          (pkgs.writeScriptBin "run" "elm-live src/Main.elm -- --output=elm.js --debug & chromium --app=http://localhost:8000")
          pkgs.elmPackages.elm
          pkgs.elmPackages.elm-live
          pkgs.elmPackages.elm-language-server
        ];
      };
    };
}
