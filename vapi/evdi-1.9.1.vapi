[CCode (cheader_filename="evdi_lib.h")]
namespace Evdi {

    [CCode (cname="struct evdi_lib_version")]
    public struct LibVersion {
        int version_major;
        int version_minor;
        int version_patchlevel;
    }

    [CCode (cname = "evdi_get_lib_version")]
    public void get_lib_version(out LibVersion version);

    public const string EVDI_INVALID_HANDLE;

    [CCode (cname = "evdi_add_device")]
    public int add_device ();

    [SimpleType]
    [CCode (cname="enum evdi_device_status", has_type_id = false)]
    public struct DeviceStatus: int {}

    [CCode (cname = "evdi_check_device")]
    public DeviceStatus check_device (int device);

    [CCode (cname = "struct evdi_device_context", free_function = "evdi_close", has_type_id = false)]
    [Compact]
    public class Handle {
        [CCode (cname = "evdi_open")]
        public static Handle? open (int device);

        [CCode (cname = "evdi_open_attached_to")]
        public static Handle? open_attached_to(string sysfs_parent_device);

        [CCode (cname = "evdi_connect")]
        public void connect (uchar[] edid, uint32 sku_area_limit);

        [CCode (cname = "evdi_disconnect")]
        public void disconnect ();

        [CCode (cname = "evdi_enable_cursor_events")]
        public void enable_cursor_events (bool enable);

        [CCode (cname = "evdi_grab_pixels")]
        public void grab_pixels(out Rect[] rects);

        [CCode (cname = "evdi_register_buffer")]
        public void register_buffer(Buffer buffer);

        [CCode (cname = "evdi_unregister_buffer")]
        public void unregister_buffer(int bufferId);

        [CCode (cname = "evdi_request_update")]
        public bool request_update(int bufferId);

        [CCode (cname = "evdi_ddcci_response")]
        public void ddcci_response(out uchar[] buffer, out bool result);

        [CCode (cname = "evdi_handle_events")]
        public void handle_events(EventContext evtctx);

        [CCode (cname = "evdi_get_event_ready")]
        public Selectable get_event_ready();

        [CCode (cname = "evdi_set_logging")]
        public void set_logging(Logging logging);
    }

    [SimpleType]
    [CCode (cname = "evdi_selectable", has_type_id = false)]
    public struct Selectable: int {
    }

    [CCode (cname="struct evdi_rect")]
    public struct Rect {
        int x1;
        int y1;
        int x2;
        int y2;
    }

    [CCode (cname="struct evdi_mode")]
    public struct Mode {
        int width;
        int height;
        int refresh_rate;
        int bits_per_pixel;
        uint pixel_format;
    }

    [CCode (cname="struct evdi_buffer")]
    public struct Buffer {
        int id;
        void *buffer;
        int width;
        int height;
        uint stride;
        Rect[] rects;
        int rect_count;
    }

    [CCode (cname="struct evdi_cursor_set")]
    public struct CursorSet {
        int32 hot_x;
        int32 hot_y;
        uint32 width;
        uint32 height;
        uint8 enabled;
        uint32 buffer_length;
        uint32 *buffer;
        uint32 pixel_format;
        uint32 stride;
    }

    [CCode (cname="struct evdi_cursor_move")]
    public struct CursorMove {
        int32 x;
        int32 y;
    }

    [CCode (cname="struct evdi_ddcci_data")]
    public struct DdcciData {
        uint16 address;
        uint16 flags;
        uint32 buffer_length;
        uint8 *buffer;
    }

    [CCode (cname="struct evdi_event_context")]
    [Compact]
    public class EventContext {
        [CCode (cname = "dpms_handler")]
        public delegate void DpmsHandler (int dpms_mode);
        [CCode (cname = "mode_changed_handler")]
        public delegate void ModeChangedHandler (Mode mode);
        [CCode (cname = "update_ready_handler")]
        public delegate void UpdateReadyHandler (int buffer_to_be_updated);
        [CCode (cname = "crtc_state_handler")]
        public delegate void CrtcStateHandler (int state);
        [CCode (cname = "cursor_set_handler")]
        public delegate void CursorSetHandler (CursorSet cursor_set);
        [CCode (cname = "cursor_move_handler")]
        public delegate void CursorMoveHandler (CursorMove cursor_move);
        [CCode (cname = "ddcci_data_handler")]
        public delegate void DdcciDataHandler (DdcciData ddcci_data);
    }

    [CCode (cname="struct evdi_logging")]
    [Compact]
    public class Logging {
        [CCode (cname = "function")]
        public delegate void Function ();
    }
}