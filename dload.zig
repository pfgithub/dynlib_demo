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
    const lbry = try loadLibrary("libdl.so.0.0.0", Library);
    std.debug.print("Added is {}\n", .{lbry.add(1, 2)});
}
