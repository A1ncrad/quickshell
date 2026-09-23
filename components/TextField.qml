import QtQuick
import QtQuick.Layouts
import qs.config

// Pill-shaped text input with a leading icon and a placeholder
Rectangle {
    id: root

    property alias text: input.text
    property alias icon: glyph.text
    property alias echoMode: input.echoMode // TextInput.Password for passwords
    property string placeholder: ""

    function focusInput() { input.forceActiveFocus() }

    implicitWidth: Theme.fieldWidth
    implicitHeight: Theme.fieldHeight
    radius: height / 2
    color: Theme.controlFill

    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: Theme.fieldPadding
        anchors.rightMargin: Theme.fieldPadding
        spacing: Theme.gap

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
