{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
  };

  outputs = { nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      run = pkgs.writeScriptBin "run"
        "elm-live src/Main.elm -- --output=elm.js --debug & chromium --app=http://localhost:8000";
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = [run] ++ (with pkgs.elmPackages; [ elm elm-live elm-language-server ]);
      };
    };
}
