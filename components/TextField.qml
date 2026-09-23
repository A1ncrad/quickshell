import QtQuick
import QtQuick.Layouts
import qs.config

// Pill-shaped text input with a leading icon and a placeholder
Rectangle {
    id: root

    property alias text: input.text
    property alias icon: glyph.text
    property string placeholder: ""

    function focusInput() { input.forceActiveFocus() }

    implicitWidth: 300
    implicitHeight: 40
    radius: height / 2
    color: Qt.alpha(Theme.surfaceVariant, 0.5)

    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: 14
        anchors.rightMargin: 14
        spacing: 10

        Icon {
            id: glyph
            color: Theme.outline
            visible: text !== ""
        }

        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true

            TextInput {
                id: input
                anchors.fill: parent
                verticalAlignment: TextInput.AlignVCenter
                color: Theme.text
                selectionColor: Theme.primary
                selectedTextColor: Theme.textOnPrimary
                font.family: Theme.font
                font.pixelSize: Theme.fontSize
                clip: true
                // Let the owner's Keys handler see keys (Enter, arrows…) before the input does
                Keys.forwardTo: [root]
            }

            StyledText {
                anchors.verticalCenter: parent.verticalCenter
                text: root.placeholder
                color: Theme.outline
                visible: input.text === ""
            }
        }
    }
}
