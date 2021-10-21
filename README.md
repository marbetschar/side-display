# Side Display

Use your tablet as a second display for elementary OS.

## State of Development

Package and ship libmutter v40.5 using Flatpak works:

```bash
$ flatpak-builder build com.github.marbetschar.side-display.yml --user --force-clean --install
```

Create a virtual monitor using the packaged libmutter fails:

```bash
$ flatpak run --command=sh com.github.marbetschar.side-display

[📦 com.github.marbetschar.side-display ~]$ mutter --x11 --virtual-monitor 1024x768

(mutter:40): GLib-GIO-ERROR **: 10:40:29.656: Settings schema 'org.gnome.settings-daemon.peripherals.touchscreen' is not installed
Trace/breakpoint trap (core dumped)
```