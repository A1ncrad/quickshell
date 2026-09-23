import QtQuick
import QtQuick.Layouts
import qs.config

// Rounded background (translucent, see Theme.transparency); children are laid out in a row
Rectangle {
    default property alias content: row.data
    property alias spacing: row.spacing

    implicitWidth: row.implicitWidth + Theme.padding * 2
    implicitHeight: Theme.barHeight
    radius: height / 2
    color: Theme.panel

    RowLayout {
        id: row
        anchors.centerIn: parent
        spacing: Theme.gap
    }
}
