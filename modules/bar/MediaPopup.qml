import QtQuick
import qs.config
import qs.modules.common

// swaync-style media card under the media pill
BarPopup {
    name: "media"
    panel: card
    align: Qt.AlignLeft

    MediaCard { id: card }
}
