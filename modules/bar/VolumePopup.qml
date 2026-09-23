import QtQuick
import QtQuick.Layouts
import qs.components
import qs.config
import qs.modules.common
import qs.services

// Windows 11-style volume flyout under the bar's right pill
BarPopup {
    name: "volume"
    anchors.right: true
    margins.right: Theme.barMargin
    implicitWidth: content.implicitWidth
    implicitHeight: content.implicitHeight

    Pill {
        id: content

        VolumeIcon {
            color: Theme.primary
            TapHandler { onTapped: Audio.toggleMute() }
        }

        Slider {
            value: Audio.volume / 100
            fillColor: Audio.muted ? Theme.text : Theme.primary
            onMoved: v => Audio.setVolume(v)
        }

        StyledText {
            text: Audio.volume
            horizontalAlignment: Text.AlignRight
            Layout.minimumWidth: Theme.fontSize * 1.8 // fits "100"
        }
    }
}
