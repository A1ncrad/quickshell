pragma Singleton

import Quickshell
import Quickshell.Networking as QsNet

Singleton {
    readonly property var device: QsNet.Networking.devices.values.find(d => d.connected) ?? null
    readonly property var network: device?.networks.values.find(n => n.connected) ?? null

    readonly property bool connected: device !== null
    readonly property bool wifi: device?.type === QsNet.DeviceType.Wifi
    readonly property string name: network?.name ?? ""
    readonly property real strength: network?.signalStrength ?? 0 // 0..1, Wi-Fi only
}
