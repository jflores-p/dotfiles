from libqtile.config import Key, Screen, Group, Drag, Click
from libqtile.command import lazy
from libqtile import layout, bar, widget
from libqtile import hook
from typing import List  # noqa: F401

import os
import socket
import subprocess

mod = "mod4"
alt = "mod1" #LEFT-ALT

myTerm = "alacritty"

keys = [
    # Applications
    Key([mod, "shift"], "Return", lazy.spawn("rofi -show run"),
        desc='rofi launcher'),

    Key([mod, alt], "e", lazy.spawn(myTerm+" -e sh ./.config/vifm/scripts/vifmrun"),
        desc='Vifm with image preiew'),

     Key([mod, alt], "q", lazy.spawn("brave"),
        desc='Vifm with image preiew'),

    # Switch between windows in current stack pane
    Key([mod], "k", lazy.layout.down()),
    Key([mod], "j", lazy.layout.up()),

    Key([mod, "shift"], "k", lazy.layout.shuffle_down(),
        desc='Move windows down in current stack'),

    Key([mod, "shift"], "j", lazy.layout.shuffle_up(),
         desc='Move windows up in current stack'),

    Key([mod], "plus", lazy.layout.grow(), lazy.layout.increase_nmaster(),
        desc='Expand window (MonadTall), increase number in master pane (Tile)'),

    Key([mod], "minus",lazy.layout.shrink(), lazy.layout.decrease_nmaster(),
        desc='Shrink window (MonadTall), decrease number in master pane (Tile)'),
    
    Key([mod, alt], "0", lazy.layout.normalize(),
         desc='normalize window size ratios'),
     
    Key([mod, "control"], "Return", lazy.layout.toggle_split(),
        desc='Toggle between split and unsplit sides of stack'),

    # Switch window focus to other pane(s) of stack
    Key([alt], "Tab", lazy.layout.next()),

    Key([mod, "shift"], "space", lazy.layout.rotate(), lazy.layout.flip(),
        desc='Switch which side main pane occupies (XmonadTall)'),

    Key([mod], "Return", lazy.spawn(myTerm)),

    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout()),
    Key([mod], "w", lazy.window.kill()),

    Key([mod, "control"], "r", lazy.restart()),
    Key([mod, "control"], "q", lazy.shutdown()),
    Key([mod], "r", lazy.spawncmd()),
]

### BAR COLORS ###

colors = [["#282a36","#282a36"],    # 0  # panel background
          ["#434758","#434758"],    # 1  # alternative panel background
          ["#ffffff","#ffffff"],    # 2  # default foreground
          ["#8d62a9","#8d62a9"],    # 3  # clock widget
          ["#A77AC4","#A77AC4"],    # 4  # 
          ["#e1acff","#e1acff"],    # 5  # focsed ws
          ["#668bd7","#668bd7"],    # 6  # memory widget
          ["#7197E7","#7197E7"],    # 7  # net widget
          ["#ff5555","#ff5555"],    # 8  # not used ws
          ["#fda55c","#fda55c"],    # 9  # 
          ["#09b5a6","#09b5a6"],    # 10 #
          ["#ebccda","#ebccda"]]    # 11 #

### GROUPS ###

group_names = ["WWW", "GO", "TERM", "FILE", "EXT"]

groups = [Group(name = 'a', layout = 'max', label = 'WWW'),
          Group(name = 's', layout = 'monadtall', label = 'GO'),
          Group(name = 'd', layout = 'monadtall', label = 'TERM'),
          Group(name = 'f', layout = 'max', label = 'FILE')]

for i in groups:
    keys.extend([
        # mod1 + letter of group = switch to group
        Key([mod], i.name, lazy.group[i.name].toscreen()),

        # mod1 + shift + letter of group = switch to & move focused window to group
        Key([mod, "shift"], i.name, lazy.window.togroup(i.name)),
    ])

layout_theme = {"border_width": 1,
                "margin" : 1,
                "border_focus": colors[3][0],
                "border_normal": colors[7][0] }

layouts = [
    layout.Max(**layout_theme),
    layout.Stack(num_stacks=2, **layout_theme),
    layout.MonadTall(**layout_theme)
]

widget_defaults = dict(
    font='Hurmit Nerd Font',
    fontsize=12,
    padding=3,
    foreground = colors[2],
    background = colors[0]
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.Sep(
                    linewidth = 0,
                    padding = 3,
                    ),
                widget.GroupBox(
                    fontsize = 10,
                    padding_x = 3,
                    padding_y = 3,
                    borderwidth = 0,
                    active = colors[6],
                    inactive = colors[8],
                    rounded = False,
                    highlight_method = "text",
                    this_current_screen_border = colors[5],
                    this_screen_border = colors[3],
                    other_current_screen_border = colors[0],
                    other_screen_border = colors[0],
                    ),
                widget.Prompt(
                    fontsize = 9,
                    padding = 10,
                    foreground = colors[3],
                    background = colors[1]
                    ),
                widget.WindowName(
                    show_state = False
                    ),
                widget.TextBox(text='', foreground = colors[9]),
                widget.CPU(
                    format = "CPU {load_percent}% ",
                    update_interval = 0.75,
                    foreground = colors[9]
                    ),
                widget.TextBox(text='|', foreground = colors[1]),
                widget.TextBox(text='ﱨ', foreground = colors[7]),
                widget.Memory(
                    foreground = colors[7]
                    ),
                widget.TextBox(text='|', foreground = colors[1]),
                widget.TextBox(text=' ', foreground = colors[8]),
                widget.DF(
                    partition = "/home/joako/",
                    format = "({uf}{m}|{r:.0f}%)",
                    visible_on_warn = False,
                    foreground = colors[8],
                    ),
                widget.TextBox(text='|', foreground = colors[1]),
                widget.Net(
                    interface = "enp0s3",
                    format = "{down} ↓↑{up} ",
                    foreground = colors[11]
                    ),
                widget.TextBox(text='|', foreground = colors[1]),
                widget.TextBox(text='墳', foreground = colors[10]),
                widget.Volume(
                    foreground = colors[10]
                    ),
                widget.TextBox(text='|', foreground = colors[1]),
                widget.Clock(
                    font = "Hurmit Nerd Font Bold",
                    foreground = colors[3],
                    format = "%A, %B %d - [%H:%M]"
                    ),
                widget.Sep(
                    linewidth = 0,
                    padding = 10,
                    ),
            ],
            22,
        ),
    ),
]

@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser('~')
    subprocess.call([home + '/.config/qtile/autostart.sh'])


# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
main = None
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(float_rules=[
    {'wmclass': 'confirm'},
    {'wmclass': 'dialog'},
    {'wmclass': 'download'},
    {'wmclass': 'error'},
    {'wmclass': 'file_progress'},
    {'wmclass': 'notification'},
    {'wmclass': 'splash'},
    {'wmclass': 'toolbar'},
    {'wmclass': 'confirmreset'},  # gitk
    {'wmclass': 'makebranch'},  # gitk
    {'wmclass': 'maketag'},  # gitk
    {'wname': 'branchdialog'},  # gitk
    {'wname': 'pinentry'},  # GPG key password entry
    {'wmclass': 'ssh-askpass'},  # ssh-askpass
])
auto_fullscreen = True
focus_on_window_activation = "smart"

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
