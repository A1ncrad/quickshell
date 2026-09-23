pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

// Current wallpaper, read from hyprpaper.conf (change-wallpaper/nextwall and prevwall
// rewrite its path line)
Singleton {
    id: root

    property string path: ""

    FileView {
        path: `${Quickshell.env("HOME")}/.config/hypr/hyprpaper.conf`
        watchChanges: true
        onFileChanged: reload()
        onLoaded: {
            const match = text().match(/^\s*path\s*=\s*(.+?)\s*$/m)
            root.path = match ? match[1].replace(/^~/, Quickshell.env("HOME")) : ""
        }
    }
}
