const std = @import("std");
const r = @import("raven");
const Io = std.Io;
var title: r.Rid = r.R_INVALID_ID;
var name: r.Rid = r.R_INVALID_ID;

pub fn main() void {
    if (r.Rinit(r.R_BACKEND_VULKAN) == 0) return;
    const xml =
        \\<Window Title="Hello" Width="360" Height="200">
        \\    <VBox Spacing="10" Slot.Padding="16">
        \\        <Label Name="title" Text="Hello" TextSize="20"/>
        \\        <TextInput Name="name" Placeholder="Your name"/>
        \\        <Button Text="Greet" Style="Primary" OnClicked="greet"/>
        \\    </VBox>
        \\</Window>
    ;
    const window = r.Rwindow_create_from_xml(xml, xml.len);
    title = r.Rwidget_find(window, "title");
    name = r.Rwidget_find(window, "name");
    r.Raction_bind("greet", greet, null);
    while (r.Rwait_frame(-1.0) != 0) {}
    r.Rshutdown();
}

fn greet(sender: r.Rid, action: ?[*:0]const u8, user_data: ?*anyopaque) callconv(.c) void {
    _ = sender;
    _ = action;
    _ = user_data;
    const who = std.mem.span(r.Rtext_input_get_text(name) orelse "");
    var buffer: [256]u8 = undefined;
    const text = std.fmt.bufPrintSentinel(&buffer, "Hello, {s}!", .{who}, 0) catch return;
    r.Rlabel_set_text(title, text.ptr);
}
