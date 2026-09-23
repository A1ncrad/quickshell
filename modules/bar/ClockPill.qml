import QtQuick
import qs.components
import qs.modules.common
import qs.services

Pill {
    TapHandler { onTapped: Popups.toggle("calendar") }

    IconLabel { icon: "schedule"; label: Time.time }
}
