import Quickshell
import QtQuick
import qs.components

// Search results; the current row is the one Enter launches
ListView {
    id: root

    property int visibleRows: 8

    signal launched(var app)

    function move(delta) {
        if (count > 0) currentIndex = Math.max(0, Math.min(count - 1, currentIndex + delta))
    }

    implicitWidth: 480
    implicitHeight: Math.max(0, Math.min(count, visibleRows) * (44 + spacing) - spacing)
    spacing: 2
    clip: true
    boundsBehavior: Flickable.StopAtBounds

    onModelChanged: currentIndex = 0
    onCurrentIndexChanged: positionViewAtIndex(currentIndex, ListView.Contain)

    delegate: ListItem {
        required property var modelData

        width: ListView.view.width
        title: modelData.name
        icon: Quickshell.iconPath(modelData.icon, true)
        selected: ListView.isCurrentItem
        onClicked: root.launched(modelData)
    }
}
