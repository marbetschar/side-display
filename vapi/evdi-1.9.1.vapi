[CCode (cheader_filename="evdi_lib.h")]
namespace Evdi {

    [CCode (cname="evdi_rect")]
    public struct Rect {
        int x1;
        int y1;
        int x2;
        int y2;
    }
}