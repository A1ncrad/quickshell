pragma Singleton

import Quickshell
import QtQuick

Singleton {
    readonly property string time: Qt.formatDateTime(clock.date, "hh:mm")
    readonly property string date: Qt.formatDateTime(clock.date, "dddd, d MMMM")

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }
}
