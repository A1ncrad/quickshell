pragma Singleton

import Quickshell
import Quickshell.Services.Pipewire

Singleton {
    id: root

    readonly property PwNode sink: Pipewire.defaultAudioSink
    readonly property bool ready: sink?.ready ?? false
    readonly property int volume: Math.round((sink?.audio?.volume ?? 0) * 100)
    readonly property bool muted: sink?.audio?.muted ?? false

    function setVolume(value) { if (sink?.audio) sink.audio.volume = Math.max(0, Math.min(1, value)) }
    function toggleMute() { if (sink?.audio) sink.audio.muted = !sink.audio.muted }

    // Node audio properties are only populated for tracked nodes
    PwObjectTracker { objects: [root.sink] }
}
