pragma Singleton

import Quickshell

// The open popup ("" when none). One at a time, so opening one closes the other;
// also lets other widgets react (e.g. the volume OSD stays hidden while the volume popup is open)
Singleton {
    property string current: ""

    function toggle(name) { current = current === name ? "" : name }
    function close() { current = "" }
}
