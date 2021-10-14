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

        Evdi.Rect? c = null;

        main_window.show_all ();
    }

    public static int main (string[] args) {
        return new Application ().run (args);
    }
}