pragma Singleton

import Quickshell
import QtQuick

Singleton {
    // Colours: Material roles from matugen (see Colors.qml).
    // Names must not start with "on": QML reads onX as a signal handler
    readonly property color surface: Colors.roles.shell_surface          // bar, pills, popups
    readonly property color surfaceVariant: Colors.roles.shell_highlight // hover, tracks, borders
    readonly property color text: Colors.roles.shell_text               // on_surface
    readonly property color outline: Colors.roles.outline                // secondary text

    readonly property color primary: Colors.roles.primary // accent
    readonly property color textOnPrimary: Colors.roles.shell_text_on_primary
    readonly property color secondary: Colors.roles.secondary
    readonly property color tertiary: Colors.roles.tertiary
    readonly property color error: Colors.roles.error

    // Transparency: false makes the whole shell opaque. Hyprland blurs behind the
    // bar, popups, OSD and launcher (layer_rule in hypr/modules/windowrules.lua);
    // with opaque surfaces the blur is simply hidden
    readonly property bool transparency: true
    readonly property color panel: Qt.alpha(surface, transparency ? 0.6 : 1) // pills, cards
    // media card: its base, and the blurred cover drawn over it
    readonly property color mediaCardBase: transparency ? "transparent" : surface
    readonly property real mediaCoverOpacity: transparency ? 0.5 : 1

    // Fonts
    readonly property string font: "Google Sans Flex"
    readonly property string iconFont: "Material Symbols Rounded"
    readonly property int fontSize: 16
    readonly property int fontSizeSmall: 14
    readonly property int fontSizeLarge: 19
    readonly property int iconSize: 16

    // Sizes
    readonly property int barHeight: 33
    readonly property int barMargin: 5 // bar distance from screen edges
    readonly property int padding: 11 // horizontal padding inside a pill
    readonly property int gap: 8      // between items in a pill
    readonly property int iconGap: 6  // between an icon and its label
    readonly property int radius: 8   // buttons, calendar days
}
