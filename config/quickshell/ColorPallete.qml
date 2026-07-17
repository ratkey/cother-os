import QtQuick

QtObject {
    id: root
    // ==================== SEMANTIC COLORS ====================

    // Core semantic
    readonly property color primary: "#458588"
    readonly property color secondary: "#689d6a"
    readonly property color accent: "#d79921"

    // Status
    readonly property color success: "#98971a"
    readonly property color warning: "#d65d0e"
    readonly property color error: "#cc241d"

    // ==================== SURFACE/TEXT ====================

    readonly property color background: "#282828"
    readonly property color surface: "#3c3836"
    readonly property color text: "#ebdbb2"
    readonly property color textMuted: "#bdae93"

    // ==================== STATE ====================

    readonly property color disabled: "#665c54"
    readonly property color border: "#504945"

    // ==================== PROGRESS BAR ====================

    readonly property color progressBackground: "#3c3836"
    readonly property color progressFill: "#458588"

    // Stage colors
    readonly property color stageEmpty: error
    readonly property color stageLow: warning
    readonly property color stageMedium: accent
    readonly property color stageFull: success
}
