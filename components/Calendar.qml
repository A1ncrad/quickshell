import QtQuick
import QtQuick.Layouts
import qs.config

// Month view modelled on shadcn/ui Calendar: ‹ Month Year ›, weekday row, 6×7 day grid.
// Week start and names follow the system locale.
ColumnLayout {
    id: root

    property var today: new Date()
    property var selected: new Date()
    property int year: today.getFullYear()
    property int month: today.getMonth() // 0..11

    // First cell: the start of the week containing the 1st
    readonly property var firstCell: {
        const first = new Date(year, month, 1)
        const offset = (first.getDay() - Qt.locale().firstDayOfWeek + 7) % 7
        return new Date(year, month, 1 - offset)
    }

    function showMonth(offset) {
        const d = new Date(year, month + offset, 1)
        year = d.getFullYear()
        month = d.getMonth()
    }

    // Back to the current month with today selected
    function reset() {
        today = new Date()
        selected = today
        year = today.getFullYear()
        month = today.getMonth()
    }

    function sameDay(a, b) {
        return a.getFullYear() === b.getFullYear() && a.getMonth() === b.getMonth() && a.getDate() === b.getDate()
    }

    spacing: Theme.gap

    RowLayout {
        IconButton { icon: "chevron_left"; onClicked: root.showMonth(-1) }

        StyledText {
            Layout.fillWidth: true
            horizontalAlignment: Text.AlignHCenter
            text: `${Qt.locale().standaloneMonthName(root.month)} ${root.year}`
            font.pixelSize: Theme.fontSizeSmall
            font.weight: Font.Medium
        }

        IconButton { icon: "chevron_right"; onClicked: root.showMonth(1) }
    }

    GridLayout {
        columns: 7
        rowSpacing: Theme.gapTight
        columnSpacing: Theme.gapTight

        // Su Mo Tu ...
        Repeater {
            model: 7
            StyledText {
                Layout.preferredWidth: Theme.itemSize
                horizontalAlignment: Text.AlignHCenter
                text: Qt.locale().standaloneDayName((Qt.locale().firstDayOfWeek + index) % 7, Locale.ShortFormat).slice(0, 2)
                color: Theme.outline
                font.pixelSize: Theme.fontSizeTiny
            }
        }

        Repeater {
            model: 42
            CalendarDay {
                readonly property var cellDate: new Date(root.firstCell.getFullYear(), root.firstCell.getMonth(), root.firstCell.getDate() + index)

                day: cellDate.getDate()
                outside: cellDate.getMonth() !== root.month
                today: root.sameDay(cellDate, root.today)
                selected: root.sameDay(cellDate, root.selected)
                onClicked: root.selected = cellDate
            }
        }
    }
}
