pragma Singleton

import Quickshell
import Quickshell.Services.UPower

Singleton {
    readonly property UPowerDevice device: UPower.displayDevice
    readonly property bool available: device.isLaptopBattery
    readonly property int percentage: Math.round(device.percentage * 100) // UPower reports 0..1
    readonly property bool charging: device.state === UPowerDeviceState.Charging
}
