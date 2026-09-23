import Quickshell
import QtQuick
import QtQuick.Layouts
import qs.components
import qs.config

// Avatar and username over the password field on glass, then what went wrong.
// Enter submits, Escape clears; the field shakes on a wrong password.
ColumnLayout {
    id: root

    property LockContext context
    required property Item backdrop

    function focusInput() { field.focusInput() }

    spacing: Theme.gapLarge

    RoundedImage {
        id: avatar
        Layout.alignment: Qt.AlignHCenter
        Layout.preferredWidth: Theme.avatarSizeLarge
        Layout.preferredHeight: Theme.avatarSizeLarge
        radius: width / 2
        source: `file://${Quickshell.env("HOME")}/.face`
        fallbackIcon: "person"

        GlassEdge { radius: avatar.radius }
    }

    StyledText {
        Layout.alignment: Qt.AlignHCenter
        Layout.bottomMargin: Theme.gap
        text: Quickshell.env("USER")
        font.pixelSize: Theme.fontSizeLarge
        font.variableAxes: Theme.axes(Theme.weightMedium)
    }

    Glass {
        id: glass

        Layout.fillWidth: true
        Layout.preferredHeight: Theme.fieldHeightLarge
        backdrop: root.backdrop
        radius: height / 2
        edgeColor: root.context.errorVisible ? Theme.error : "transparent"

        transform: Translate { id: shift }

        TextField {
            id: field

            anchors.fill: parent
            color: "transparent"
            icon: root.context.busy ? "hourglass_empty" : "lock"
            placeholder: "Type your password"
            echoMode: TextInput.Password
            text: root.context.password
            onTextChanged: root.context.password = text

            Keys.onPressed: event => {
                switch (event.key) {
                case Qt.Key_Return:
                case Qt.Key_Enter: root.context.submit(); break
                case Qt.Key_Escape: root.context.password = ""; break
                default: return
                }
                event.accepted = true
            }
        }

        SequentialAnimation {
            id: shake
            loops: 2
            NumberAnimation { target: shift; property: "x"; to: -Theme.gap; duration: Theme.durationShort / 4 }
            NumberAnimation { target: shift; property: "x"; to: Theme.gap; duration: Theme.durationShort / 2 }
            NumberAnimation { target: shift; property: "x"; to: 0; duration: Theme.durationShort / 4 }
        }
    }

    // Always laid out (empty when there's nothing to say), so nothing jumps
    StyledText {
        Layout.fillWidth: true
        horizontalAlignment: Text.AlignHCenter
        text: root.context.failures > 1 && root.context.message !== ""
            ? `${root.context.message} (${root.context.failures} attempts)`
            : root.context.message
        color: Theme.error
        font.pixelSize: Theme.fontSizeSmall
        // Keeps its text while fading out, so it doesn't vanish mid-fade
        opacity: root.context.errorVisible ? 1 : 0
        Behavior on opacity { NumberAnimation { duration: Theme.durationMedium; easing.type: Theme.easing } }
    }

    Connections {
        target: root.context
        function onFailuresChanged() { shake.restart() }
    }
}
