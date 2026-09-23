pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

// Installed apps: search ranked by match quality, then by how often each was launched
Singleton {
    id: root

    readonly property string terminal: "kitty" // for runInTerminal apps, as in hypr/modules/programs.lua
    readonly property var list: DesktopEntries.applications.values.filter(app => !app.noDisplay)

    function launches(app) { return history.launches[app.id] ?? 0 }

    // 0 = no match. Name prefix > word prefix > substring > other fields > letters in order
    function score(app, query) {
        const name = app.name.toLowerCase()
        if (name.startsWith(query)) return 5
        if (name.split(/[\s\-_.]+/).some(word => word.startsWith(query))) return 4
        if (name.includes(query)) return 3
        if ([app.genericName, app.comment, ...app.keywords].join(" ").toLowerCase().includes(query)) return 2
        let i = 0
        for (const c of name) if (c === query[i]) i++
        return i === query.length ? 1 : 0
    }

    function search(text) {
        const query = text.trim().toLowerCase()
        return list
            .map(app => ({ app, score: query ? score(app, query) : 1 }))
            .filter(match => match.score > 0)
            .sort((a, b) => b.score - a.score
                || launches(b.app) - launches(a.app)
                || a.app.name.localeCompare(b.app.name))
            .map(match => match.app)
    }

    function launch(app) {
        const context = { command: app.runInTerminal ? [terminal, "-e", ...app.command] : app.command }
        if (app.workingDirectory) context.workingDirectory = app.workingDirectory
        Quickshell.execDetached(context) // detached, so apps outlive a shell restart

        history.launches = Object.assign({}, history.launches, { [app.id]: launches(app) + 1 })
    }

    FileView {
        path: Quickshell.statePath("launcher.json")
        onAdapterUpdated: writeAdapter()
        onLoadFailed: error => { if (error === FileViewError.FileNotFound) writeAdapter() }

        JsonAdapter {
            id: history
            property var launches: ({}) // app id -> launch count
        }
    }
}
