{
  inputs.zig2nix.url = "github:Cloudef/zig2nix";

  outputs = { zig2nix, ... }:
    let
      system = "x86_64-linux";
      env = zig2nix.outputs.zig-env.${system} {
        enableOpenGL = true;
        enableWayland = true;
        enableAlsa = true;
      };
    in
    {
      devShells.${system}.default = env.mkShell { };
    };
}
