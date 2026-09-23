import QtQuick
import QtQuick.Effects
import qs.config

// Everything on a lock screen: clock in a top corner (Theme.lockClockOnRight), the
// password prompt in the centre, network and battery in the bottom right.
Item {
    id: root

    property LockContext context

    readonly property int margin: Math.round(Math.min(width, height) * Theme.lockMargin)

    LockBackground {
        id: background
        anchors.fill: parent
    }

    Item {
        id: content
        anchors.fill: parent

        // Lift the text off the wallpaper
        layer.enabled: true
        layer.effect: MultiEffect {
            shadowEnabled: true
            shadowColor: Theme.shadow
            shadowBlur: Theme.shadowBlur
        }

        LockClock {
            anchors.top: parent.top
            anchors.left: Theme.lockClockOnRight ? undefined : parent.left
            anchors.right: Theme.lockClockOnRight ? parent.right : undefined
            anchors.margins: root.margin
            alignRight: Theme.lockClockOnRight
        }

        PasswordPrompt {
            id: prompt
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            width: Theme.lockPromptWidth
            context: root.context
            backdrop: background
        }

        LockStatus {
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.margins: root.margin
            backdrop: background
        }
    }

    // The single entrance: everything fades in while the prompt rises into place.
    // It moves the offset rather than a transform, so the glass follows along
    ParallelAnimation {
        running: true
        NumberAnimation { target: content; property: "opacity"; from: 0; to: 1; duration: Theme.durationLong; easing.type: Theme.easing }
        NumberAnimation { target: prompt; property: "anchors.verticalCenterOffset"; from: Theme.sectionGap; to: 0; duration: Theme.durationLong; easing.type: Theme.easing }
    }

    Component.onCompleted: prompt.focusInput()
}
