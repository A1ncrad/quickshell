import Quickshell
import Quickshell.Wayland
import QtQuick

// Session lock: a LockSurface on every screen, all sharing one LockContext.
// Locks as soon as it's created and quits the process once unlocked.
Scope {
    readonly property alias context: lockContext

    LockContext {
        id: lockContext
        onUnlocked: lock.locked = false
    }

    WlSessionLock {
        id: lock
        locked: true
        onLockedChanged: if (!locked) quitTimer.start()

        LockSurface { context: lockContext }
    }

    // Let the unlock reach the compositor before exiting; if the process dies while
    // still locked, Hyprland keeps the session locked (red screen)
    Timer {
        id: quitTimer
        interval: 100
        onTriggered: Qt.quit()
    }
}
