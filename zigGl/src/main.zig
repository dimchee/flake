const std = @import("std");
const gl = @import("gl");
const glfw = @import("glfw");

var procs: gl.ProcTable = undefined;

pub fn main() !void {
    try glfw.init();
    defer glfw.terminate();

    const window: *glfw.Window = try glfw.createWindow(800, 640, "Hello World", null, null);
    defer glfw.destroyWindow(window);
    glfw.makeContextCurrent(window);
    defer glfw.makeContextCurrent(null);

    if (!procs.init(glfw.getProcAddress)) return error.InitFailed;

    gl.makeProcTableCurrent(&procs);
    defer gl.makeProcTableCurrent(null);

    gl.Enable(gl.COLOR_BUFFER_BIT);
    while (!glfw.windowShouldClose(window)) {
        if (glfw.getKey(window, glfw.KeyEscape) == glfw.Press) {
            glfw.setWindowShouldClose(window, true);
        }
        gl.ClearColor(1, 0, 0, 1);
        gl.Clear(gl.COLOR_BUFFER_BIT);

        glfw.swapBuffers(window);
        glfw.pollEvents();
    }
}
