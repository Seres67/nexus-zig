const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{
        .default_target = .{
            .cpu_arch = .x86_64,
            .os_tag = .windows,
            .abi = .gnu,
        },
    });
    const optimize = b.standardOptimizeOption(.{});

    _ = b.addModule("nexus_zig", .{
        .root_source_file = .{ .src_path = .{ .owner = b, .sub_path = "src/nexus.zig" } },
        .target = target,
        .optimize = optimize,
    });
}
