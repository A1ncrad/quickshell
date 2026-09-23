pragma Singleton

import Quickshell
import QtQuick

// Design tokens for the whole shell: Material You colours from matugen, frosted glass.
// Modules take every colour, size, spacing, radius and timing from here; add a token
// rather than a literal when one is missing.
Singleton {
    // ── Colour ─────────────────────────────────────────────────────────────────
    // Material roles from matugen (see Colors.qml).
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

    // Tonal fill for controls sitting on glass (text fields, button groups)
    readonly property color controlFill: Qt.alpha(surfaceVariant, 0.55)
    // Scrim: darkens a backdrop behind text so it stays readable
    readonly property color scrim: surface
    readonly property real scrimStrength: 0.85
    readonly property real disabledOpacity: 0.5
    // Soft shadow lifting text off a busy backdrop (lock screen)
    readonly property color shadow: Qt.alpha("black", 0.5)
    readonly property real shadowBlur: 0.6 // MultiEffect shadowBlur, 0..1

    // ── Glass ──────────────────────────────────────────────────────────────────
    // false makes the whole shell opaque. Hyprland blurs behind the bar, popups, OSD
    // and launcher (layer_rule in hypr/modules/windowrules.lua), which then only need
    // `panel`. Panels over a backdrop in the same window (lock screen, media card
    // cover) blur it themselves (components/Glass) with the glass* values
    readonly property bool transparency: true
    readonly property color panel: Qt.alpha(surface, transparency ? 0.6 : 1) // pills, cards
    readonly property color glassTint: Qt.alpha(surface, transparency ? 0.35 : 1)
    // Glass rim (components/GlassEdge): tinted with the accent like the Hyprland window
    // borders, lit top left, fading toward the bottom right
    readonly property color glassEdgeLight: Qt.alpha(primary, 0.5)
    readonly property color glassEdge: Qt.alpha(primary, 0.25)
    readonly property color glassEdgeDim: Qt.alpha(primary, 0.1)
    readonly property real glassEdgeWidth: 1.5
    readonly property bool glassRim: false // false: no rim, panels end at their frost

    // Elevation: shadows under floating panels (components/Shadow). Keep the shadow's
    // alpha below ignore_alpha in hypr/modules/windowrules.lua (0.45), or Hyprland
    // blurs behind the shadow too
    readonly property bool elevation: false // false: no shadows, windows leave no room for them
    readonly property color elevationShadow: Qt.alpha("black", 0.35)
    readonly property int shadowBlurRadius: 24
    readonly property int shadowOffset: 6 // light from above: the shadow falls lower
    readonly property int shadowSpace: elevation ? 32 : 0 // room a window leaves around its panel (>= blur + offset)
    readonly property real glassBlur: 1         // MultiEffect blur, 0..1
    readonly property int glassBlurMax: 48      // blur radius in px at glassBlur 1
    readonly property real glassSaturation: 0.2 // a little vibrancy through the frost
    readonly property int borderWidth: 1

    // Media card: its base, the blurred cover drawn over it, and the scrim on top
    readonly property color mediaCardBase: transparency ? "transparent" : surface
    readonly property real mediaCoverOpacity: transparency ? 0.5 : 1
    readonly property color mediaCoverScrim: Qt.alpha(scrim, 0.6)

    // ── Type ───────────────────────────────────────────────────────────────────
    readonly property string font: "Google Sans Flex"
    readonly property string iconFont: "Material Symbols Rounded"
    readonly property int fontSizeTiny: 12 // calendar weekday names
    readonly property int fontSizeSmall: 14
    readonly property int fontSize: 16
    readonly property int fontSizeLarge: 19
    readonly property int fontSizeHeadline: 26
    readonly property int fontSizeDisplay: 128 // lock screen clock
    readonly property int iconSize: 16
    readonly property int iconSizeLarge: 20 // tray icons, list item fallbacks

    // Google Sans Flex variable axes. Use font.variableAxes: Theme.axes(Theme.weightMedium)
    readonly property int weightRegular: 450
    readonly property int weightMedium: 600
    readonly property int weightDisplay: 560
    readonly property int roundness: 100 // ROND axis: 0 square … 100 fully rounded
    function axes(weight) { return { "wght": weight, "ROND": roundness } }

    // ── Spacing ────────────────────────────────────────────────────────────────
    readonly property int gapTight: 2    // rows of a list or grid, button groups
    readonly property int gapSmall: 4    // stacked lines of text
    readonly property int iconGap: 6     // between an icon and its label
    readonly property int gap: 8         // between items in a pill or row
    readonly property int padding: 11    // horizontal padding inside a pill or list row
    readonly property int gapLarge: 12   // between related blocks (cover and its text)
    readonly property int cardPadding: 12
    readonly property int fieldPadding: 14 // text field sides
    readonly property int sectionGap: 32 // between unrelated groups

    // ── Shape & size ───────────────────────────────────────────────────────────
    readonly property int radius: 8       // buttons, calendar days, small covers
    readonly property int radiusLarge: 12 // cards, glass panels

    readonly property int barHeight: 33
    readonly property int barMargin: 5       // bar distance from screen edges
    readonly property int controlSize: 28    // icon buttons, list item icons
    readonly property int itemSize: 32       // tray items, menu entries, calendar days
    readonly property int listItemHeight: 44
    readonly property int fieldHeight: 40
    readonly property int fieldHeightLarge: 50 // lock screen password
    readonly property int avatarSize: 36
    readonly property int avatarSizeLarge: 88 // lock screen
    readonly property int coverSize: 52      // album art in a compact media row
    readonly property int coverSizeLarge: 100 // album art in the media card
    readonly property int trackHeight: 4     // progress bars, slider tracks
    readonly property int knobSize: 14       // slider handle
    readonly property int dotSize: 6         // workspace dot
    readonly property int dotSizeActive: 11
    readonly property int ringWidth: 2       // active workspace ring
    readonly property int separatorSpace: 9  // height a separator takes up

    readonly property int labelMaxWidth: 400    // IconLabel default
    readonly property int pillLabelMaxWidth: 200 // e.g. the bar's media title
    readonly property int menuMinWidth: 200
    readonly property int sliderWidth: 160
    readonly property int progressWidth: 100
    readonly property int fieldWidth: 300
    readonly property int mediaCardWidth: 400
    readonly property int launcherWidth: 480
    readonly property int osdMargin: 60 // OSD distance from the bottom edge
    readonly property int popupGap: 6   // between the bar and its popups

    // ── Motion ─────────────────────────────────────────────────────────────────
    readonly property int durationFast: 100   // values following input (volume bar)
    readonly property int durationShort: 150  // hovers, popups, small feedback
    readonly property int durationMedium: 400 // state changes (blur in, dim)
    readonly property int durationLong: 600   // entrances
    readonly property int easing: Easing.OutCubic
    readonly property real enterScale: 0.97   // popups grow from this scale

    readonly property int osdTimeout: 1500   // OSD hides after this long
    readonly property int popupTimeout: 3000 // bar popups close after the pointer leaves
    readonly property int errorTimeout: 2500 // lock screen error shows this long

    // ── Lock screen ────────────────────────────────────────────────────────────
    readonly property real lockMargin: 0.06    // edge inset, as a fraction of the screen
    readonly property int lockPromptWidth: 360
    readonly property bool lockClockOnRight: false // true: clock in the top right
}
