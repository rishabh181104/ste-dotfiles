# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE. from libqtile import bar, layout, qtile, widget, hook
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
import subprocess
import os
import logging

logging.basicConfig(level=logging.DEBUG)

mod = "mod4"
alt = "mod1"
terminal = "alacritty"
browser = "brave-browser-nightly"
code_editor = "/home/ste/./cursor.AppImage"
github_desktop = "github-desktop"
subprocess.call(
    ["xrandr", "--output", "eDP-1", "--mode", "1920x1080", "--rate", "60.01"]
)


@hook.subscribe.startup
def autostart():
    home = os.path.expanduser("~/.config/qtile/autostart.sh")
    subprocess.run([home])


keys = [
    Key([alt], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([alt], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([alt], "j", lazy.layout.down(), desc="Move focus down"),
    Key([alt], "k", lazy.layout.up(), desc="Move focus up"),
    Key([alt], "space", lazy.layout.next(), desc="Move window focus to other window"),
    Key(
        [mod, "control"],
        "h",
        lazy.layout.shuffle_left(),
        desc="Move window to the left",
    ),
    Key(
        [mod, "control"],
        "l",
        lazy.layout.shuffle_right(),
        desc="Move window to the right",
    ),
    Key([mod, "control"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "control"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    Key([mod, "shift"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "shift"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "shift"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "shift"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod], "b", lazy.spawn(browser), desc="Launch browser"),
    Key([mod], "u", lazy.spawn(code_editor), desc="Launch editor"),
    Key([mod], "g", lazy.spawn(github_desktop), desc="Launch github_desktop"),
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),
    Key(
        [mod],
        "f",
        lazy.window.toggle_fullscreen(),
        desc="Toggle fullscreen on the focused window",
    ),
    Key(
        [mod],
        "t",
        lazy.window.toggle_floating(),
        desc="Toggle floating on the focused window",
    ),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "space", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),
    Key([mod], "k", lazy.group.next(), desc="Move to the next group (desktop)"),
    Key([mod], "j", lazy.group.prev(), desc="Move to the previous group (desktop)"),
    # Volume Control
    Key(
        [],
        "F3",
        lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ +5%"),
        desc="Increase volume",
    ),
    Key(
        [],
        "F2",
        lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ -5%"),
        desc="Decrease volume",
    ),
    Key(
        [],
        "F1",
        lazy.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle"),
        desc="Toggle mute",
    ),
    # Brightness Control
    Key([], "F5", lazy.spawn("brightnessctl set 5%-"), desc="Decrease brightness"),
    Key([], "F6", lazy.spawn("brightnessctl set +5%"), desc="Increase brightness"),
]

for vt in range(1, 8):
    keys.append(
        Key(
            ["control", "mod1"],
            f"f{vt}",
            lazy.core.change_vt(vt).when(func=lambda: qtile.core.name == "wayland"),
            desc=f"Switch to VT{vt}",
        )
    )


groups = [Group(i) for i in ["", "", "", "��", "", "󰡈", "", "", ""]]
groups_hotkeys = "123456789"

for g, k in zip(groups, groups_hotkeys):
    keys.extend(
        [
            Key(
                [mod],
                k,
                lazy.group[g.name].toscreen(),
                desc=f"Switch to group {g.name}",
            ),
            Key(
                [mod, "shift"],
                k,
                lazy.window.togroup(g.name, switch_group=False),
                desc=f"Switch to & move focused window to group {g.name}",
            ),
        ]
    )

# Colors
dracula = {
    "rosewater": "#f5e0dc",
    "flamingo": "#f2cdcd",
    "pink": "#f5c2e7",
    "mauve": "#cba6f7",
    "red": "#f38ba8",
    "maroon": "#eba0ac",
    "peach": "#fab387",
    "yellow": "#f9e2af",
    "green": "#a6e3a1",
    "teal": "#94e2d5",
    "sky": "#89dceb",
    "white": "#d9e0ee",
    "grey": "#6e6c7e",
    "black": "#1a1826",
}

layouts = [
    layout.MonadTall(
        margin=5,
        border_width=2,
    ),
    layout.Columns(border_focus_stack=["#89dceb", "#89dd3d"], border_width=4),
    layout.Max(),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

widget_defaults = dict(
    font="JetBrainsMono Nerd Font",
    fontsize=16,
    padding=2,
    foreground=dracula["black"],
)
extension_defaults = widget_defaults.copy()


def get_brightness():
    # Get current brightness percentage
    brightness = (
        subprocess.check_output(
            "brightnessctl g | awk '{print int($1/255*100)}'", shell=True
        )
        .decode()
        .strip()
    )
    return f"☀️ {brightness}%"


def get_widgets(primary=False):
    widgets = [
        widget.Spacer(length=2, background="#00000000"),  # Spacer at the start
        widget.TextBox(
            text="",
            padding=0,
            fontsize=30,
            foreground=dracula["black"],
            background="#00000000",
        ),
        widget.GroupBox(
            highlight_method="line",
            background=dracula["black"],
            highlight_color=[dracula["green"], dracula["green"]],
            inactive=dracula["grey"],
        ),
        widget.TextBox(
            text="",
            padding=0,
            fontsize=30,
            foreground=dracula["black"],
            background="#00000000",
        ),
        widget.Spacer(length=10, background="#00000000"),  # Spacer after GroupBox
        widget.WindowName(
            fontsize=18,
            padding=20,
            foreground=dracula["white"],
        ),
        widget.TextBox(
            text="",
            padding=0,
            fontsize=30,
            foreground=dracula["sky"],
            background="#00000000",
        ),
        widget.Volume(
            fmt="󰖀 {}",
            mute_command="pactl set-sink-mute @DEFAULT_SINK@ toggle",
            volume_command="pactl list sinks | grep 'Volume:' | head -n 1 | awk '{print $5}'",  # Get current volume
            foreground=dracula["black"],
            background=dracula["sky"],
        ),
        widget.TextBox(
            text="",
            padding=0,
            fontsize=30,
            foreground=dracula["sky"],
            background="#00000000",
        ),
        widget.Spacer(length=40, background="#00000000"),  # Spacer after WindowName
        widget.TextBox(
            text="",
            padding=0,
            fontsize=30,
            foreground=dracula["green"],
            background="#00000000",
        ),
        widget.TextBox(
            text=get_brightness(),
            foreground=dracula["black"],
            background=dracula["green"],
            update_interval=1,
        ),
        widget.TextBox(
            text="",
            padding=0,
            fontsize=30,
            foreground=dracula["green"],
            background="#00000000",
        ),
        widget.Spacer(length=40, background="#00000000"),  # Spacer after Brightness
        widget.TextBox(
            text="",
            padding=0,
            fontsize=30,
            foreground=dracula["peach"],
            background="#00000000",
        ),
        widget.CPU(
            format="󰻠 {load_percent:04}%",
            foreground=dracula["black"],
            background=dracula["peach"],
            update_interval=1,  # Update every second
        ),
        widget.TextBox(
            text="",
            padding=0,
            fontsize=30,
            foreground=dracula["peach"],
            background="#00000000",
        ),
        widget.Spacer(length=40, background="#00000000"),  # Spacer after CPU
        widget.TextBox(
            text="",
            padding=0,
            fontsize=30,
            foreground=dracula["maroon"],
            background="#00000000",
        ),
        widget.Clock(
            format="󰥔 %I:%M: %p",
            foreground=dracula["black"],
            background=dracula["maroon"],
        ),
        widget.TextBox(
            text="",
            padding=0,
            fontsize=30,
            foreground=dracula["maroon"],
            background="#00000000",
        ),
        widget.Spacer(length=40, background="#00000000"),  # Spacer after Clock
        widget.TextBox(
            text="",
            padding=0,
            fontsize=30,
            foreground=dracula["grey"],
            background="#00000000",
        ),
        widget.Systray(
            foreground=dracula["grey"],
        ),
        widget.TextBox(
            text="",
            padding=0,
            fontsize=30,
            foreground=dracula["grey"],
            background="#00000000",
        ),
    ]

    if primary:
        return widgets


screens = [
    Screen(
        top=bar.Bar(
            get_widgets(primary=True),
            22,
            margin=2,
            background="#00000000",
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag(
        [mod],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()
    ),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
floats_kept_above = True
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# xcursor theme (string or None) and size (integer) for Wayland backend
wl_xcursor_theme = None
wl_xcursor_size = 30

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
