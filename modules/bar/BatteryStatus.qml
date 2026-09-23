import qs.components
import qs.config
import qs.services

// Battery icon follows charge level; hidden when there is no battery
Icon {
    readonly property int level: Math.min(6, Math.floor(Battery.percentage / 100 * 7))

    visible: Battery.available
    color: Battery.percentage <= 10 && !Battery.charging ? Theme.error : Theme.primary
    text: Battery.charging ? "battery_android_bolt"
        : Battery.percentage >= 95 ? "battery_android_full"
        : Battery.percentage <= 10 ? "battery_android_alert"
        : `battery_android_${level}`
}
