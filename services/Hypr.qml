pragma Singleton

import Quickshell
import Quickshell.Hyprland

// Hyprland 0.56 (Lua config) dispatchers.
// HyprlandWorkspace.activate() sends the old "workspace N" syntax, which is rejected.
Singleton {
    function focusWorkspace(id) { Hyprland.dispatch(`hl.dsp.focus({ workspace = ${id} })`) }
    function toggleSpecial(name) { Hyprland.dispatch(`hl.dsp.workspace.toggle_special("${name}")`) }
}
