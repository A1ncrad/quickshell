import Quickshell
import Quickshell.Services.Pam
import QtQuick
import qs.config

// Auth state shared by every screen's lock surface, so whichever monitor has focus
// edits the same password
Scope {
    id: root

    property string password: ""
    property string message: "" // last failure or PAM error
    property int failures: 0    // bumped on every failed attempt (the prompt shakes)
    // Whether to show `message` now: for Theme.errorTimeout after it's set, or until
    // you start typing again
    property bool errorVisible: false
    readonly property bool busy: pam.active

    signal unlocked()

    onMessageChanged: {
        errorVisible = message !== ""
        if (errorVisible) errorTimer.restart()
    }
    onFailuresChanged: {
        errorVisible = message !== ""
        errorTimer.restart()
    }
    onPasswordChanged: if (password !== "") errorVisible = false

    Timer {
        id: errorTimer
        interval: Theme.errorTimeout
        onTriggered: root.errorVisible = false
    }

    function submit() {
        if (password === "" || pam.active) return
        message = ""
        pam.start()
    }

    PamContext {
        id: pam

        // Same stack as hyprlock (/etc/pam.d/hyprlock includes login), so
        // faillock applies here too
        config: "login"

        onPamMessage: {
            if (pam.responseRequired) pam.respond(root.password)
            else if (pam.messageIsError) root.message = pam.message
        }

        onCompleted: result => {
            if (result === PamResult.Success) {
                root.unlocked()
                return
            }
            root.password = ""
            root.failures++
            // Keep a PAM message (e.g. faillock's "account locked") if there was one
            if (root.message === "")
                root.message = result === PamResult.MaxTries ? "Too many attempts" : "Wrong password"
        }

        onError: error => {
            root.password = ""
            root.message = PamError.toString(error)
        }
    }
}
