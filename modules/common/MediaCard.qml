import QtQuick
import QtQuick.Effects
import QtQuick.Layouts
import Quickshell.Widgets
import qs.components
import qs.config
import qs.services

// swaync-style media card: blurred cover as background, cover, title/artist, controls
ClippingRectangle {
    implicitWidth: 400
    implicitHeight: layout.implicitHeight + 24
    radius: Theme.radius * 1.5
    color: Theme.mediaCardBase
    border.color: Theme.surfaceVariant
    border.width: 1

    // Background: the cover, blurred and dimmed for readable text
    Image {
        id: backdrop
        anchors.fill: parent
        source: Media.artUrl
        fillMode: Image.PreserveAspectCrop
        asynchronous: true
        visible: false
    }

    MultiEffect {
        anchors.fill: parent
        source: backdrop
        visible: backdrop.status === Image.Ready
        opacity: Theme.mediaCoverOpacity
        blurEnabled: true
        blur: 1
        blurMax: 64
    }

    Rectangle {
        anchors.fill: parent
        color: Qt.alpha(Theme.surface, 0.6)
    }

    RowLayout {
        id: layout
        anchors.fill: parent
        anchors.margins: 12
        spacing: 12

        RoundedImage {
            source: Media.artUrl
            fallbackIcon: "music_note"
            Layout.preferredWidth: 100
            Layout.preferredHeight: 100
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: 4

            StyledText {
                Layout.fillWidth: true
                text: Media.title || "Nothing playing"
                font.pixelSize: Theme.fontSizeLarge
                font.weight: Font.Bold
            }

            StyledText {
                Layout.fillWidth: true
                text: Media.artist
                visible: text !== ""
                color: Theme.outline
                font.pixelSize: Theme.fontSizeSmall
                font.weight: Font.Bold
            }

            MediaControls {
                Layout.alignment: Qt.AlignHCenter
                Layout.topMargin: 8
                visible: Media.player !== null
            }
        }
    }
}
