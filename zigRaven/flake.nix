{
  description = "Simple zig + Raven GUI flake"
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
  outputs =
    { nixpkgs, ... }:
    {
      devShells.x86_64-linux.default =
        with nixpkgs.legacyPackages.x86_64-linux;
        mkShell {
          packages = [
            zig zls
            libX11 vulkan-loader
            # vulkan-tools spirv-tools
          ];
        };
    };
}
