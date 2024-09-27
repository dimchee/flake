const std = @import("std");
const rl = @cImport(@cInclude("raylib.h"));

pub fn main() !void {
    rl.InitWindow(800, 450, "Hello!");
    defer rl.CloseWindow();
    while (!rl.WindowShouldClose()) {
        rl.BeginDrawing();
        defer rl.EndDrawing();
        rl.ClearBackground(rl.RED);
    }
}
