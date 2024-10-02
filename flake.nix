{
  description = "dimchee's templates";
  inputs.official.url = "github:NixOS/templates";
  outputs = {self, official}: {
    templates = {
      default = self.templates.shell;
      shell = {
        path = ./shell;
        description = "Quick shell";
      };
      zig2nix = {
        path = ./zig2nix;
        description = "Simple flake using zig2nix";
      };
      zig2nixRaylib = {
        path = ./zig2nixRaylib;
        description = "Simple flake using zig2nix + raylib";
      };
      zigRaylibRaw = {
        path = ./zigRaylibRaw;
        description = "Flake for zig + raw raylib";
      };
      zigRaylib = {
        path = ./zigRaylib;
        description = "Flake for zig + raylib";
      };
      elmPorts = {
        path = ./elmPorst;
        descriptrion = "Flake for elm ports";
      };
    } // official.templates;
  };
}
