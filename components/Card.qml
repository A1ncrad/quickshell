import QtQuick
import QtQuick.Layouts
import qs.config

// Bordered panel (translucent, see Theme.transparency); children are laid out in a column
Rectangle {
    id: root

    default property alias content: column.data
    property int padding: Theme.cardPadding
    property bool elevated: true // shadow; the window needs Theme.shadowSpace of room

    implicitWidth: column.implicitWidth + padding * 2
    implicitHeight: column.implicitHeight + padding * 2
    radius: Theme.radiusLarge
    color: Theme.panel

    ColumnLayout {
        id: column
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
