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
        ''
        cargo build --target=wasm32-unknown-unknown --release
        wasm-bindgen --target=web target/wasm32-unknown-unknown/release/wasm_bindgen_test.wasm --out-dir=./target/wasm-bindgen
        live-server
        '';
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = [
          run
          pkgs.cargo
          pkgs.rustc
          pkgs.lld
          pkgs.wasm-bindgen-cli
          pkgs.taplo
          pkgs.nodePackages.live-server
        ];
      };
    };
}
