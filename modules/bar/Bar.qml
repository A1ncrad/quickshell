import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import qs.config

PanelWindow {
    id: bar

    anchors { top: true; left: true; right: true }
    margins { top: Theme.barMargin; left: Theme.barMargin; right: Theme.barMargin }

    implicitHeight: Theme.barHeight
    color: "transparent"
    // Hyprland blurs behind the pills (layer_rule in hypr/modules/windowrules.lua)
    WlrLayershell.namespace: "quickshell:bar"

    MediaPill {
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
    }

    RowLayout {
        id: center
        anchors.centerIn: parent
        spacing: Theme.gapTight

        ClockPill { id: clock }
        Workspaces {}
    }

    StatusPill {
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
    }

    CalendarPopup { bar: bar; clockX: center.x + clock.x + clock.width / 2 }
    MediaPopup { bar: bar }
    TrayPopup { bar: bar }
    VolumePopup { bar: bar }
}
