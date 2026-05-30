# Niri GTK

GTK Library and CLI tool for monitoring the [Niri socket](https://github.com/YaLTeR/niri/wiki/IPC).
Built to be used with gtk tooling such as AGS and gnim


To get started read the [wiki](https://aylur.github.io/astal/)


## Installation

1. install dependencies

```sh [<i class="devicon-archlinux-plain"></i> Arch]
sudo pacman -Syu meson vala json-glib gobject-introspection
```

```sh [<i class="devicon-fedora-plain"></i> Fedora]
sudo dnf install meson gcc valac json-glib-devel gobject-introspection-devel
```

```sh [<i class="devicon-ubuntu-plain"></i> Ubuntu]
sudo apt install meson valac libjson-glib-dev gobject-introspection
```

2. clone repo

```sh
git clone https://github.com/sameoldlab/niri-gtk
cd src
```

3. install

```sh
meson setup build
meson install -C build
```

Most distros recommend manual installs in `/usr/local`,
which is what `meson` defaults to. If you want to install to `/usr`
instead which most package managers do, set the `prefix` option:

```sh
meson setup --prefix /usr build
```

## Usage

Setup is the same Astal libraries, using it will look something like this (with differences based on language):

### Get Data

Get outputs, workspaces, and windows from the default object as arrays:

```c
// psuedocode
import Niri from "AstalNiri"
niri = Niri.get_default()

// Loop through
niri.windows.each(w => { // do stuff })
niri.workspaces.each(w => { // do stuff })
niri.outputs.each(o => { // do stuff })
```

or iterating by layer:
```c
for o in niri.outputs {
  for ws in o.workspaces {
    for win in ws.windows {
      print("window ", win.name, " on output ", ws.idx, " from output ", o.name)
    }
  }
}
```

### Send Actions
```c
// psuedocode
import Niri from "AstalNiri"
// All actions are available through Niri.msg
Niri.msg.focus_workspace_by_name("media")
// Some object specific actions can also be called through the object 
niri = Niri.get_default()
mediaWs = niri.get_workspace(3)
mediaWs.focus()
```

GTK Signals have the same names as Niri IPC events. 

