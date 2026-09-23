import QtQuick
import QtQuick.Effects
import qs.config

// Material elevation: a soft shadow under a panel, drawn only outside it so it can't
// dull translucent glass. Put it inside the panel (parent: the panel) with the panel's
// radius; the window needs Theme.shadowSpace of room around the panel.
Item {
    id: root

    property real radius: 0

    readonly property int space: Theme.shadowSpace

    x: -space
    y: -space
    width: parent.width + space * 2
    height: parent.height + space * 2
    z: -1
    visible: Theme.elevation

    RectangularShadow {
        x: root.space
        y: root.space
        width: root.width - root.space * 2
        height: root.height - root.space * 2
        radius: root.radius
        offset.y: Theme.shadowOffset
        blur: Theme.shadowBlurRadius
        color: Theme.elevationShadow
    }

    // Cut the panel's own shape out of the shadow
    layer.enabled: true
    layer.effect: MultiEffect {
        maskEnabled: true
        maskInverted: true
        maskSource: cutout
        maskThresholdMin: 0.5
        maskSpreadAtMin: 1
    }

    Item {
        id: cutout
        anchors.fill: parent
        layer.enabled: true
        visible: false

        Rectangle {
            x: root.space
            y: root.space
            width: root.width - root.space * 2
            height: root.height - root.space * 2
            radius: root.radius
        }
    }
}
