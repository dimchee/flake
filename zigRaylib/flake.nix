{
  inputs.nixpkgs.url = "github:nixos/nixpkgs";
  outputs = { nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      xDeps = with pkgs.xorg; [ libXcursor libXi libXrandr libXinerama];
      wayDeps = with pkgs; [ wayland libxkbcommon libdecor wayland-scanner ];
    in
    {
      devShell.${system} = pkgs.mkShell {
        buildInputs = [ pkgs.libGL pkgs.zig pkgs.zls ] ++ wayDeps ++ xDeps;
      };
    };
}
