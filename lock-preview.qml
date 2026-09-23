import Quickshell
import QtQuick
import qs.modules.lock

// The lock screen in a normal window, for working on its look without locking the
// session. A correct password just logs "unlocked".
// Run with: qs -p ~/.config/quickshell/lock-preview.qml
ShellRoot {
    LockContext {
        id: lockContext
        onUnlocked: console.log("unlocked")
    }

    FloatingWindow {
        implicitWidth: 1920
        implicitHeight: 1080

        LockContent {
            anchors.fill: parent
            context: lockContext
        }
    }
}
