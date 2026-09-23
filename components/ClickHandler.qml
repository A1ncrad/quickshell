import Quickshell
import QtQuick

// Runs a shell command when its parent is left-clicked
TapHandler {
    property string command: ""

    acceptedButtons: Qt.LeftButton
    onTapped: if (command) Quickshell.execDetached(["sh", "-c", command])
}
