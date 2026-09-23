import qs.components
import qs.config
import qs.services

// Volume icon follows level and mute state
Icon {
    color: Theme.tertiary
    text: Audio.muted ? "volume_off"
        : Audio.volume === 0 ? "volume_mute"
        : Audio.volume < 50 ? "volume_down"
        : "volume_up"
}
