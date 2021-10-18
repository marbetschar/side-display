namespace SideDisplay.DBus {

    [DBus (name = "org.gnome.Mutter.ScreenCast")]
    public interface ScreenCast : Object {

        /**
        RecordVirtual:
        @properties: Properties
        @stream_path: Path to the new stream object

        Record a virtual area that will be represented as a virtual monitor. The
        width and height corresponds to the non-scaled intended stream size.

        Available @properties include:

        * "cursor-mode" (u): Cursor mode. Default: 'hidden' (see below)
                            Available since API version 2.
        * "is-platform" (b): Whether this virtual output should be considered
                    part of the platform, meaning it will not be
                    interpreted as if the screen is shared, but more
                    transparently as if it was a real monitor.
                    Available since API version 3. Default: FALSE.

        Available cursor mode values:

        0: hidden - cursor is not included in the stream
        1: embedded - cursor is included in the framebuffer
        2: metadata - cursor is included as metadata in the PipeWire stream
        */
        [DBus (name = "RecordVirtual")]
        public abstract GLib.Variant recordVirtual (GLib.Variant properties) throws Error;
    }

    [DBus (name = "org.gnome.Mutter.ScreenCast.Stream")]
    public interface Stream : Object {

        [DBus (name = "PipeWireStreamAdded")]
        public signal void pipewire_stream_added (uint node_id);
    }
}