import QtQuick
import QtQuick.Shapes
import qs.config

// Rim of a glass panel: a hairline lit from the top left that fades toward the bottom
// right, like light catching the edge of frosted glass. Fills its parent; give it the
// panel's radius. Set `color` for a solid state rim (e.g. Theme.error), which shows
// even when Theme.glassRim is off.
Shape {
    id: root

    property real radius: 0
    property color color: "transparent" // solid override; transparent = lit gradient

    readonly property bool solid: color.a > 0
    readonly property real w: Theme.glassEdgeWidth

    anchors.fill: parent
    visible: solid || Theme.glassRim
    preferredRendererType: Shape.CurveRenderer

    ShapePath {
        strokeColor: "transparent"
        strokeWidth: 0
        // Outer and inner outline; even-odd fill leaves only the ring between them
        fillRule: ShapePath.OddEvenFill
        fillGradient: LinearGradient {
            x1: 0; y1: 0
            x2: root.width; y2: root.height
            GradientStop { position: 0; color: root.solid ? root.color : Theme.glassEdgeLight }
            GradientStop { position: 0.5; color: root.solid ? root.color : Theme.glassEdge }
            GradientStop { position: 1; color: root.solid ? root.color : Theme.glassEdgeDim }
        }

        PathRectangle {
            width: root.width
            height: root.height
            radius: root.radius
        }
        PathRectangle {
            x: root.w
            y: root.w
            width: root.width - root.w * 2
            height: root.height - root.w * 2
            radius: Math.max(0, root.radius - root.w)
        }
    }
}
