#!/bin/bash

# https://wiki.archlinux.org/title/Extreme_Multihead#Using_an_HDMI_output
#
# DP-1:
#sudo sh -c 'echo on > /sys/kernel/debug/dri/0/DP-1/force'
#xrandr --newmode "SideDisplay@1024x768" 63.50  1024 1072 1176 1328  768 771 775 798 -hsync +vsync
#xrandr --addmode DP-1 "SideDisplay@1024x768"
#xrandr --output DP-1 --mode "SideDisplay@1024x768"
#xrandr --output DP-1 --off
#xrandr --delmode DP-1 "SideDisplay@1024x768"
#xrandr --rmmode "SideDisplay@1024x768"
#sudo sh -c 'echo off > /sys/kernel/debug/dri/0/DP-1/force'


# DP-2:
#sudo sh -c 'echo on > /sys/kernel/debug/dri/0/DP-2/force'
#xrandr --setmonitor SideDisplay 1024/208x768/156+1920+0 DP-2
#xrandr --delmonitor SideDisplay
#sudo sh -c 'echo off > /sys/kernel/debug/dri/0/DP-2/force'















#xrandr --newmode "1024x768_60.00"  64.11  1024 1080 1184 1344  768 769 772 795  -HSync +Vsync
#xrandr --addmode DP-1 1024x768_60.00
#xrandr --output DP-1 --mode 1024x768_60.00
# sudo sh -c 'echo off > /sys/kernel/debug/dri/0/DP-1/force'


# eDP-1 connected primary 1920x1080+0+0 (normal left inverted right x axis y axis) 293mm x 162mm

#Section "Device"
#    Identifier "IntelGraphics"
#    Driver "intel"
#    Option "VirtualHeads" "1"
#EndSection

#sudo modprobe evdi initial_device_count=1
#xrandr --setprovideroutputsource 1 0
#xrandr --newmode "1024x768_60.00"  64.11  1024 1080 1184 1344  768 769 772 795  -HSync +Vsync
#xrandr --addmode DVI-I-1-1 1024x768_60.00
#xrandr --output DVI-I-1-1 --mode 1024x768_60.00 --right-of eDP-1
#xrandr --setmonitor SideDisplay~1 1024/208x768/156+1920+0 DVI-I-1-1

#xrandr --newmode "1024x768_60.00"  64.11  1024 1080 1184 1344  768 769 772 795  -HSync +Vsync
#xrandr --addmode VIRTUAL1 1024x768_60.00
#xrandr --output VIRTUAL1 --mode 1024x768_60.00

#xrandr --output VIRTUAL1 --off

#xrandr --delmode eDP-1 2944x1080_60.00
#xrandr --rmmode "2944x1080_60.00"

# gtf 2944 1080 60
#xrandr --newmode "2944x1080_60.00" 265.10 2944 3128 3448 3952 1080 1081 1084 1118 -HSync +Vsync
#xrandr --addmode eDP-1 2944x1080_60.00
# xrandr --output eDP-1 --mode 2944x1080_60.00

# https://man.archlinux.org/man/xrandr.1
# --setmonitor name geometry outputs
#     Define a new monitor with the given geometry and associated to
#     the given outputs. The output list is either the keyword none or
#     a comma-separated list of outputs. The geometry is either the keyword
#     auto, in which case the monitor will automatically track the geometry
#     of the associated outputs, or a manual specification in the form
#     w/mmwxh/mmh+x+y where w, h, x, y are in pixels and mmw, mmh are the
#     physical dimensions of the monitor.

#xrandr --delmonitor SideDisplay~1
#xrandr --delmonitor SideDisplay~2

#xrandr --setmonitor SideDisplay~1 1920/293x1080/162+0+0 eDP-1
#xrandr --setmonitor SideDisplay~2 1024/208x768/156+1920+0 none

#xrandr --setmonitor SideDisplay~1 960/146x1080/162+0+0 eDP-1
#xrandr --setmonitor SideDisplay~2 960/147x1080/156+960+0 none

#xrandr --fb 1921x1080
#xrandr --fb 1920x1080
#xrandr --fb 2944x1080
#xrandr --output eDP-1 --mode 1920x1080
