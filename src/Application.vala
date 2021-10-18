public class SideDisplay.Application: Gtk.Application {

    private DBus.Mutter.ScreenCast? dbus_screencast = null;
    private DBus.ScreenCast.Session? dbus_screencast_session = null;
    private DBus.ScreenCast.Stream? dbus_screencast_stream = null;

    public Application () {
        Object (
            application_id: "com.github.marbetschar.side-display",
            flags: GLib.ApplicationFlags.FLAGS_NONE
        );
    }

    protected override void activate () {
        var main_window = new Gtk.ApplicationWindow (this) {
            default_height = 300,
            default_width = 300,
            title = "Side Display"
        };

        main_window.show_all ();

        try {
            connect_dbus ();
        } catch (Error e) {
            critical ("Error connecting to dbus: %s", e.message);
        }

        var session_path = dbus_screencast.createSession (new GLib.Variant.array (
            new GLib.VariantType ("{sv}"), {}));


        //  var screencast_properties = new GLib.Variant.array (
        //      new GLib.VariantType ("{sv}"), {
        //          // is-platform = true: this virtual output should be considered part of the platform, as if it was a real monitor
        //          new GLib.Variant("{sv}", "is-platform", new GLib.Variant.boolean(true)),
        //          // cursor-mode = 1: embedded - cursor is included in the framebuffer
        //          new GLib.Variant("{sv}", "cursor-mode", new GLib.Variant.uint32 (1))
        //      });

        //var stream_path = dbus_screencast_session.recordVirtual (screencast_properties);
        //var stream_path = dbus_screencast_session.recordVirtual (screencast_properties);
    }

    //  public override void destroy () {
    //      disconnect_dbus ();
    //      base.destroy ();
    //  }


    private void connect_dbus () throws Error {
        dbus_screencast = Bus.get_proxy_sync<DBus.Mutter.ScreenCast> (
            BusType.SESSION,
            "org.gnome.Mutter.ScreenCast",
            "/org/gnome/Mutter/ScreenCast",
            DBusProxyFlags.DO_NOT_AUTO_START
        );

        dbus_screencast_session = Bus.get_proxy_sync<DBus.ScreenCast.Session> (
            BusType.SESSION,
            "org.gnome.Mutter.ScreenCast.Session",
            "/org/gnome/Mutter/ScreenCast/Session"
        );

        dbus_screencast_stream = Bus.get_proxy_sync<DBus.ScreenCast.Stream> (
            BusType.SESSION,
            "org.gnome.Mutter.ScreenCast.Stream",
            "/org/gnome/Mutter/ScreenCast/Stream"
        );

        dbus_screencast_stream.pipewire_stream_added.connect (on_pipewire_stream_added);
    }

    private void disconnect_dbus () {
        if (dbus_screencast_session != null) {
            //dbus_screencast_session.enabled_changed.disconnect (on_enabled_changed);
        }
        dbus_screencast_session = null;
    }

    private void on_pipewire_stream_added (uint node_id) {
        warning ("on pipewire stream added: %u", node_id);
    }

    public static int main (string[] args) {
        return new Application ().run (args);
    }
}