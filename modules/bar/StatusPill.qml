import QtQuick
import Quickshell.Services.SystemTray
import qs.components
import qs.config
import qs.modules.common
import qs.services

Pill {
    // Tray overflow, as in Windows 11; hidden while the tray is empty
    // Icon {
    //     text: Popups.current === "tray" ? "expand_less" : "expand_more"
    //     color: Theme.text
    //     visible: SystemTray.items.values.length > 0
    //     TapHandler { onTapped: Popups.toggle("tray") }
    // }

    NetworkStatus {}

    Icon {
        text: "bluetooth"
        color: Theme.secondary
        visible: Bluetooth.enabled
        ClickHandler { command: "hyprctl dispatch 'hl.dsp.exec_cmd(bluetooth)'" }
    }

    VolumeIcon {
        TapHandler { onTapped: Popups.toggle("volume") }
    }

    BatteryStatus {}
}
