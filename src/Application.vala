public class SideDisplay.Application: Gtk.Application {

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

        Evdi.LibVersion version;
        Evdi.get_lib_version (out version);
        warning ("Evdi.LibVersion: %i.%i.%i", version.version_major, version.version_minor, version.version_patchlevel);

        var device_id = Evdi.add_device ();
        warning ("evdi device id: %i", device_id);

        var device_status = Evdi.check_device (device_id);
        warning ("device_status: %i", device_status);

        var device_handle = Evdi.Handle.open (device_id);
        if (device_handle != null) {
            uchar[] buffer;
            bool result;
            device_handle.ddcci_response (out buffer, out result);

            if (result) {
                warning ("ddcci response: true!");
            } else {
                warning ("ddcci response: _false_");
            }
        } else {
            warning ("handle is NULL");
        }


        main_window.show_all ();
    }

    public static int main (string[] args) {
        return new Application ().run (args);
    }
}