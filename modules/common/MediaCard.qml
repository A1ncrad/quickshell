import QtQuick
import QtQuick.Effects
import QtQuick.Layouts
import Quickshell.Widgets
import qs.components
import qs.config
import qs.services

// swaync-style media card: blurred cover as background, cover, title/artist, controls
ClippingRectangle {
    id: root

    implicitWidth: Theme.mediaCardWidth
    implicitHeight: layout.implicitHeight + Theme.cardPadding * 2
    radius: Theme.radiusLarge
    color: Theme.mediaCardBase

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
        blur: Theme.glassBlur
        blurMax: Theme.glassBlurMax
    }

    Rectangle {
        anchors.fill: parent
        color: Theme.mediaCoverScrim
    }

    RowLayout {
        id: layout
        anchors.fill: parent
        anchors.margins: Theme.cardPadding
        spacing: Theme.gapLarge

        RoundedImage {
            source: Media.artUrl
            fallbackIcon: "music_note"
            Layout.preferredWidth: Theme.coverSizeLarge
            Layout.preferredHeight: Theme.coverSizeLarge
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: Theme.gapSmall

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
                Layout.topMargin: Theme.gap
                visible: Media.player !== null
            }
        }
    }

    GlassEdge { radius: root.radius }

    // Outside the clipped content, so the shadow isn't clipped away
    Shadow {
        parent: root
        radius: root.radius
    }
}
