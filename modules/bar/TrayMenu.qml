import Quickshell
import QtQuick
import QtQuick.Layouts
import qs.components
import qs.config

// A tray item's menu drawn in the bar's style via QsMenuOpener.
// Submenus open in place, with a Back row on top.
ColumnLayout {
    id: root

    property var menu        // the tray item's QsMenuHandle
    property var stack: []   // opened submenus, innermost last

    readonly property var current: stack.length > 0 ? stack[stack.length - 1] : menu

    signal done() // an entry was triggered

    function checkGlyph(entry) {
        const on = entry.checkState === Qt.Checked
        if (entry.buttonType === QsMenuButtonType.CheckBox) return on ? "check_box" : "check_box_outline_blank"
        if (entry.buttonType === QsMenuButtonType.RadioButton) return on ? "radio_button_checked" : "radio_button_unchecked"
        return ""
    }

    spacing: 0
    Layout.minimumWidth: Theme.menuMinWidth

    QsMenuOpener {
        id: opener
        menu: root.current
    }

    MenuEntry {
        Layout.fillWidth: true
        visible: root.stack.length > 0
        text: "Back"
        indicator: "chevron_left"
        onClicked: root.stack = root.stack.slice(0, -1)
    }

    Repeater {
        model: opener.children

        Loader {
            Layout.fillWidth: true
            sourceComponent: modelData.isSeparator ? separator : entry

            Component {
                id: separator
                Separator {}
            }

            Component {
                id: entry
                MenuEntry {
                    text: modelData.text
                    icon: modelData.icon
                    enabled: modelData.enabled
                    hasChildren: modelData.hasChildren
                    indicator: root.checkGlyph(modelData)
                    onClicked: {
                        if (modelData.hasChildren) {
                            root.stack = [...root.stack, modelData]
                        } else {
                            modelData.triggered()
                            root.done()
                        }
                    }
                }
            }
        }
    }
}
