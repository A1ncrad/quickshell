import Quickshell.Wayland
import qs.config

// One screen of the lock (the content lives in LockContent, which lock-preview.qml
// also shows in a normal window)
WlSessionLockSurface {
    id: root

    property LockContext context

    color: Theme.surface // until the wallpaper has loaded

    LockContent {
        anchors.fill: parent
        // root, not parent: a surface's children sit in its content item, not on it
        context: root.context
    }
}
