namespace SideDisplay.DBus {

    [DBus (name = "org.gnome.Mutter.ScreenCast")]
    public interface Mutter.ScreenCast : Object {
        /**
        CreateSession:
        @properties: Properties
        @session_path: Path to the new session object

        * "remote-desktop-session-id" (s): The ID of a remote desktop session.
                        Remote desktop driven screen casts
                        are started and stopped by the remote
                        desktop session.
        * "disable-animations" (b): Set to "true" if the screen cast application
                        would prefer animations to be globally
                        disabled, while the session is running. Default
                        is "false". Available since version 3.
        */

        [DBus (name = "CreateSession")]
        public abstract GLib.Variant createSession (GLib.Variant properties) throws Error;
    }

    [DBus (name = "org.gnome.Mutter.ScreenCast.Session")]
    public interface ScreenCast.Session : Object {

        [DBus (name = "RecordWindow")]
        public abstract GLib.Variant recordWindow (GLib.Variant properties) throws Error;

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
    public interface ScreenCast.Stream : Object {

        [DBus (name = "PipeWireStreamAdded")]
        public signal void pipewire_stream_added (uint node_id);
    }
}