pragma Singleton

import Quickshell
import Quickshell.Bluetooth as QsBt

Singleton {
    readonly property QsBt.BluetoothAdapter adapter: QsBt.Bluetooth.defaultAdapter
    readonly property bool enabled: adapter?.enabled ?? false
}
