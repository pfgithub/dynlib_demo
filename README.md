linux:

```bash
zig build-lib -dynamic --release-fast dl.zig --output-dir out/linux
zig run dload.zig
```

windows:

```bash
zig build-lib -dynamic --release-fast dl.zig -target x86_64-windows-none --output-dir out/windows
zig build-exe -target x86_64-windows-none --output-dir out/temp dload.zig
# idk it crashes
# you should probably be able to do `wine out/temp/dload.exe` if it worked
```

mac:

```bash
zig build-lib -dynamic --release-fast dl.zig -target x86_64-macosx-none --output-dir out/mac
zig build-exe -target x86_64-macos-none --output-dir out/temp dload.zig
```
