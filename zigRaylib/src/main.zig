const std = @import("std");
const rl = @import("raylib");

pub fn main() void {
    rl.initWindow(800, 600, "Hello!");
    defer rl.closeWindow();
    while (!rl.windowShouldClose()) {
        rl.beginDrawing();
        defer rl.endDrawing();
        rl.clearBackground(rl.Color.red);
    }
}
