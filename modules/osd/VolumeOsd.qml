import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import qs.components
import qs.config
import qs.modules.common
import qs.services

// Windows 11-style popup: shows on volume/mute change, fades out after a delay
PanelWindow {
    id: root

    property bool shown: false

    function show() {
        if (!Audio.ready) return // skip initial values and sink switches
        if (Popups.current === "volume") return // the popup already shows the volume
        shown = true
        hideTimer.restart()
    }

    anchors.bottom: true // horizontally centered by the layer shell
    // Room around the pill for its shadow
    margins.bottom: Theme.osdMargin - Theme.shadowSpace
    implicitWidth: content.implicitWidth + Theme.shadowSpace * 2
    implicitHeight: content.implicitHeight + Theme.shadowSpace * 2

    visible: shown || content.opacity > 0
    color: "transparent"
    exclusionMode: ExclusionMode.Ignore
    mask: Region {} // click-through
    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.namespace: "quickshell:osd"

    Pill {
        id: content
        anchors.centerIn: parent
        elevated: true

        opacity: root.shown ? 1 : 0
        Behavior on opacity { NumberAnimation { duration: Theme.durationShort; easing.type: Theme.easing } }

        VolumeIcon { color: Theme.primary }

        ProgressBar {
            value: Audio.volume / 100
            fillColor: Audio.muted ? Theme.text : Theme.primary
        }

        StyledText {
            text: Audio.volume
            horizontalAlignment: Text.AlignRight
            Layout.minimumWidth: Theme.fontSize * 1.8 // fits "100" so the pill doesn't jump
        }
    }

    Timer {
        id: hideTimer
        interval: Theme.osdTimeout
        onTriggered: root.shown = false
    }

    Connections {
        target: Audio
        function onVolumeChanged() { root.show() }
        function onMutedChanged() { root.show() }
    }
}
