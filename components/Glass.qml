import QtQuick
import QtQuick.Effects
import Quickshell.Widgets
import qs.config

// Frosted-glass panel over a backdrop in the same window (e.g. the lock screen's
// wallpaper): shows the part of `backdrop` behind it blurred, tinted, with a light edge.
// Layer-shell windows get their blur from Hyprland instead and just use Theme.panel.
// Children go on top of the glass.
ClippingRectangle {
    id: root

    required property Item backdrop
    default property alias content: contentItem.data
    property alias edgeColor: edge.color // solid rim for a state, e.g. Theme.error

    // Backdrop area behind the panel, padded so the blur doesn't fade in at the edges
    property rect area

    function track() {
        const pos = root.mapToItem(backdrop, 0, 0)
        const pad = Theme.glassBlurMax
        area = Qt.rect(pos.x - pad, pos.y - pad, width + pad * 2, height + pad * 2)
    }

    radius: Theme.radiusLarge
    color: "transparent"

    onWidthChanged: track()
    onHeightChanged: track()
    Component.onCompleted: {
        // Follow every move of the panel or its ancestors (layouts, entrances)
        for (let item = parent; item && item !== backdrop.parent; item = item.parent) {
            item.xChanged.connect(track)
            item.yChanged.connect(track)
        }
        xChanged.connect(track)
        yChanged.connect(track)
        track()
    }

    ShaderEffectSource {
        id: behind
        sourceItem: root.backdrop
        sourceRect: root.area
        width: root.area.width
        height: root.area.height
        visible: false
    }

    MultiEffect {
        x: -Theme.glassBlurMax
        y: -Theme.glassBlurMax
        width: behind.width
        height: behind.height
        source: behind
        blurEnabled: true
        blur: Theme.glassBlur
        blurMax: Theme.glassBlurMax
        saturation: Theme.glassSaturation
    }

    Rectangle {
        anchors.fill: parent
        color: Theme.glassTint
    }

    GlassEdge {
        id: edge
        radius: root.radius
    }

    Item {
        id: contentItem
        anchors.fill: parent
    }
}
