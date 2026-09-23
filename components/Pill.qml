import QtQuick
import QtQuick.Layouts
import qs.config

// Rounded background (translucent, see Theme.transparency); children are laid out in a row
Rectangle {
    id: root

    default property alias content: row.data
    property alias spacing: row.spacing
    property bool elevated: false // shadow for floating pills; needs Theme.shadowSpace of room

    implicitWidth: row.implicitWidth + Theme.padding * 2
    implicitHeight: Theme.barHeight
    radius: height / 2
    color: Theme.panel

    RowLayout {
        id: row
        anchors.centerIn: parent
        spacing: Theme.gap
    }

    // Explicit parents: children of this file would otherwise go into the layout
    Shadow {
        parent: root
        radius: root.radius
        visible: root.elevated && Theme.elevation
    }

    GlassEdge {
        parent: root
        radius: root.radius
    }
}
