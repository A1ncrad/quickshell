import QtQuick
import qs.config
import qs.services

// The wallpaper, with a scrim from the clock's side to keep the clock readable
Item {
    id: root

    // Gradient stop position measured from the clock's side
    function fromClock(position) { return Theme.lockClockOnRight ? 1 - position : position }

    Image {
        anchors.fill: parent
        source: Wallpaper.path ? `file://${Wallpaper.path}` : ""
        fillMode: Image.PreserveAspectCrop
        asynchronous: true
    }

    Rectangle {
        anchors.fill: parent
        gradient: Gradient {
            orientation: Gradient.Horizontal
            GradientStop { position: root.fromClock(0); color: Qt.alpha(Theme.scrim, Theme.scrimStrength * 0.7) }
            GradientStop { position: root.fromClock(0.4); color: Qt.alpha(Theme.scrim, Theme.scrimStrength * 0.3) }
            GradientStop { position: root.fromClock(0.75); color: Qt.alpha(Theme.scrim, 0) }
        }
    }
}
