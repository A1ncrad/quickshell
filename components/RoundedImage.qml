import QtQuick
import Quickshell.Widgets
import qs.config

// Image with rounded corners; shows fallbackIcon until the image is loaded
ClippingRectangle {
    property alias source: image.source
    property alias fallbackIcon: fallback.text

    radius: Theme.radius
    color: Theme.surfaceVariant

    Image {
        id: image
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
        asynchronous: true
    }

    Icon {
        id: fallback
        anchors.centerIn: parent
        visible: image.status !== Image.Ready
        color: Theme.outline
    }
}
