import qs.config
import qs.modules.common

// swaync-style media card under the media pill
BarPopup {
    name: "media"
    anchors.left: true
    margins.left: Theme.barMargin
    implicitWidth: card.implicitWidth
    implicitHeight: card.implicitHeight

    MediaCard { id: card }
}
