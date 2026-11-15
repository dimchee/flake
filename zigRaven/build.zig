const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const mod = b.createModule(.{
        .root_source_file = b.path("src/main.zig"),
        .link_libc = true,
        .target = target,
        .optimize = optimize,
        .imports = &.{},
    });
    mod.addImport("raven", b.createModule(.{
        .root_source_file = b.dependency("raven", .{}).path("bindings/zig/raven.zig"),
        .target = target,
        .optimize = optimize,
    }));
    mod.linkSystemLibrary("X11", .{});
    mod.addObjectFile(b.dependency("raven-bin", .{}).path("lib/libraven.a"));
    const exe = b.addExecutable(.{ .name = "app", .root_module = mod });

    b.installArtifact(exe);
    const run_step = b.step("run", "Run the app");
    const run_cmd = b.addRunArtifact(exe);
    run_step.dependOn(&run_cmd.step);
    run_cmd.step.dependOn(b.getInstallStep());
    run_cmd.addPassthruArgs();
}
