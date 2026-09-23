import QtQuick
import qs.components
import qs.config
import qs.modules.common
import qs.services

Pill {
    TapHandler { onTapped: Popups.toggle("media") }

    IconLabel {
        icon: "music_note"
        iconColor: Theme.secondary
        maxLabelWidth: 200
        label: Media.player ? `${Media.artist || "Unknown"} — ${Media.title}` : "Nothing playing"
    }
}
