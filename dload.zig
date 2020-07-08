const std = @import("std");

const Library = struct {
    add: fn (i64, i64) callconv(.C) i64
};

pub fn loadLibrary(name: []const u8, comptime Container: type) !Container {
    var dynLib = try std.DynLib.open(name);
    var result: Container = undefined;
    inline for (@typeInfo(Container).Struct.fields) |field| {
        const value = dynLib.lookup(field.field_type, field.name[0..:0]) orelse return error.MissingField;
        @field(result, field.name) = value;
    }
    return result;
}

pub fn main() !void {
    const libname = switch (std.builtin.os.tag) {
        .linux => "out/linux/libdl.so.0.0.0",
        .windows => "out/windows/dl.dll",
        .macosx => "out/mac/libdl.0.0.0.dylib",
        else => @compileError("Unsupported platform " ++ @tagName(std.os.tag)),
    };
    const lbry = try loadLibrary(libname, Library);
    std.debug.print("Added is {}\n", .{lbry.add(1, 2)});
}
