pragma Singleton
import QtQuick

QtObject {
    property string fontFamily: "JetBrainsMono Nerd Font"
    property int fontSize: 12
    property int iconSize: 20
    // ==================== SEMANTIC COLORS ====================
    // Core semantic
    readonly property color colPrimary: "#909090"
    readonly property color colSecondary: "#a8a8a8"
    readonly property color colAccent: "#c0c0c0"
    // Status
    readonly property color colSuccess: "#8a8a8a"
    readonly property color colWarning: "#707070"
    readonly property color colError: "#3a3a3a"
    // ==================== SURFACE/TEXT ====================
    readonly property color colBackground: "#000000"
    readonly property color colSurface: "#1f1f1f"
    readonly property color colText: "#f5f5f5"
    readonly property color colTextMuted: "#b0b0b0"
    // ==================== STATE ====================
    readonly property color colDisabled: "#555555"
    readonly property color colBorder: "#2a2a2a"
    // ==================== STAGE PROGRESSION ====================
    // 0 - Empty (very dark)
    readonly property color colStage0: "#1a1a1a"
    // 1 - Very Low
    readonly property color colStage1: "#2d2d2d"
    // 2 - Low
    readonly property color colStage2: "#404040"
    // 3 - Low-Medium
    readonly property color colStage3: "#535353"
    // 4 - Medium
    readonly property color colStage4: "#666666"
    // 5 - Medium-High
    readonly property color colStage5: "#797979"
    // 6 - High
    readonly property color colStage6: "#8c8c8c"
    // 7 - Very High
    readonly property color colStage7: "#9f9f9f"
    // 8 - Full (very light)
    readonly property color colStage8: "#e0e0e0"

    // Legacy aliases for compatibility
    readonly property color colStageEmpty: colStage0
    readonly property color colStageLow: colStage2
    readonly property color colStageMedium: colStage4
    readonly property color colStageFull: colStage8
}
