import QtQuick
import qs.config

// Draggable horizontal slider; value is 0..1.
// Only reports input through moved(); the owner decides what to do with it.
Item {
    id: root

    property real value: 0
    property alias fillColor: bar.fillColor

    signal moved(real value)

    function moveTo(value) { moved(Math.max(0, Math.min(1, value))) }

    implicitWidth: Theme.sliderWidth
    implicitHeight: handle.height

    ProgressBar {
        id: bar
        anchors.verticalCenter: parent.verticalCenter
        width: root.width
        value: root.value
        animated: !mouse.pressed // don't lag behind the cursor while dragging
    }

    Rectangle {
        id: handle
        width: Theme.knobSize
        height: width
        radius: width / 2
        anchors.verticalCenter: parent.verticalCenter
        x: Math.max(0, Math.min(root.width - width, root.value * root.width - width / 2))
        color: bar.fillColor
    }

    MouseArea {
        id: mouse
        anchors.fill: parent
        onPressed: event => root.moveTo(event.x / width)
        onPositionChanged: event => { if (pressed) root.moveTo(event.x / width) }
        onWheel: event => root.moveTo(root.value + (event.angleDelta.y > 0 ? 0.05 : -0.05))
    }
}
