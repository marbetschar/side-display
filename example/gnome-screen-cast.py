#!/usr/bin/python3

import sys
import signal
import dbus
from gi.repository import GLib
from dbus.mainloop.glib import DBusGMainLoop

import gi
gi.require_version('Gst', '1.0')
from gi.repository import GObject, Gst

DBusGMainLoop(set_as_default=True)
Gst.init(None)

loop = GLib.MainLoop()

bus = dbus.SessionBus()
screen_cast_iface = 'org.gnome.Mutter.ScreenCast'
screen_cast_session_iface = 'org.gnome.Mutter.ScreenCast.Session'
screen_cast_stream_iface = 'org.gnome.Mutter.ScreenCast.Session'

screen_cast = bus.get_object(screen_cast_iface,
                             '/org/gnome/Mutter/ScreenCast')
session_path = screen_cast.CreateSession([], dbus_interface=screen_cast_iface)
print("session path: %s"%session_path)
session = bus.get_object(screen_cast_iface, session_path)

format_element = ""

if len(sys.argv) == 6 and sys.argv[1] == '-a':
    [_, _, x, y, width, height] = sys.argv
    stream_path = session.RecordArea(
        int(x), int(y), int(width), int(height),
        dbus.Dictionary({'is-recording': dbus.Boolean(True, variant_level=1),
                         'cursor-mode': dbus.UInt32(0, variant_level=1)}, signature='sv'),
        dbus_interface=screen_cast_session_iface)
elif len(sys.argv) == 2 and sys.argv[1] == '-w':
    stream_path = session.RecordWindow("",
        dbus.types.Dictionary({'cursor-mode': dbus.UInt32(1, variant_level=1)}),
        dbus_interface=screen_cast_session_iface)
elif len(sys.argv) == 4 and sys.argv[1] == '-v':
    [_, _, width, height] = sys.argv
    stream_path = session.RecordVirtual(
        dbus.Dictionary({'is-platform': dbus.Boolean(True, variant_level=1),
                         'cursor-mode': dbus.UInt32(1, variant_level=1)}, signature='sv'),
        dbus_interface=screen_cast_session_iface)
    format_element = "video/x-raw,max-framerate=60/1,width=%d,height=%d !"%(
        int(width), int(height))
else:
    stream_path = session.RecordMonitor(
        "", dbus.types.Dictionary({'cursor-mode': dbus.UInt32(1, variant_level=1)}),
        dbus_interface=screen_cast_session_iface)

print("stream path: %s"%stream_path)
stream = bus.get_object(screen_cast_iface, stream_path)

pipeline = None

def terminate():
    global pipeline
    print("pipeline: " + str(pipeline))
    if pipeline is not None:
        print("draining pipeline")
        pipeline.send_event(Gst.Event.new_eos())
        pipeline.set_state(Gst.State.NULL)
    print("stopping")
    session.Stop(dbus_interface=screen_cast_session_iface)
    loop.quit()

def on_message(bus, message):
    global pipeline
    type = message.type
    print("message pipeline: " + str(pipeline))
    if type == Gst.MessageType.EOS or type == Gst.MessageType.ERROR:
        terminate()

def on_pipewire_stream_added(node_id):
    print("added")
    global pipeline

    pipeline = Gst.parse_launch('pipewiresrc path=%u ! %s videoconvert ! glimagesink'%(
        node_id, format_element))
    pipeline.set_state(Gst.State.PLAYING)
    pipeline.get_bus().connect('message', on_message)

stream.connect_to_signal("PipeWireStreamAdded", on_pipewire_stream_added)

session.Start(dbus_interface=screen_cast_session_iface)

try:
    loop.run()
except KeyboardInterrupt:
    print("interrupted")
    terminate()
