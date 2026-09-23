import QtQuick
import QtQuick.Layouts
import qs.config

// Bordered panel (translucent, see Theme.transparency); children are laid out in a column
Rectangle {
    default property alias content: column.data
    property int padding: 12

    implicitWidth: column.implicitWidth + padding * 2
    implicitHeight: column.implicitHeight + padding * 2
    radius: Theme.radius * 1.5
    color: Theme.panel
    border.color: Theme.surfaceVariant
    border.width: 1

    ColumnLayout {
        id: column
        anchors.centerIn: parent
        spacing: Theme.gap
    }
}
