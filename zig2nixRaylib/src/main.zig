const std = @import("std");
const rl = @import("raylib");

pub fn main() void {
    std.debug.print("test", .{});
    rl.initWindow(800, 600, "test window");
    defer rl.closeWindow();
    while (!rl.windowShouldClose()) {
        rl.beginDrawing();
        defer rl.endDrawing();
        rl.clearBackground(rl.Color.red);
    }
}
