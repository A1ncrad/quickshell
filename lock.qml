import Quickshell
import qs.modules.lock

// Lock screen entry point. It runs as its own process, separate from the bar, so
// reloading or crashing the bar can't take the lock down with it.
// Run with: qs -n -p ~/.config/quickshell/lock.qml   (-n: no-op if already locked)
ShellRoot {
    Lock {}
}
