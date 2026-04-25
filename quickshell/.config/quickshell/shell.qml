import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

PanelWindow {
    id: root

    // Theme
    property color colBg: "#0e201a"
    property color colFg: "#c2c7c5"
    property color colMuted: "#444b6a"
    property color colCyan: "#0db9d7"
    property color colBlue: "#7aa2f7"
    property color colYellow: "#e0af68"
    property string fontFamily: "JetBrainsMono Nerd Font"
    property int fontSize: 14

    anchors.top: true
    anchors.left: true
    anchors.right: true
    color: "transparent"
    implicitHeight: 30

    LeftBar {
        anchors.left: parent.left
        height: parent.height
        colBg: root.colBg
        colFg: root.colFg
        colMuted: root.colMuted
        colCyan: root.colCyan
        colBlue: root.colBlue
        colYellow: root.colYellow
        fontFamily: root.fontFamily
        fontSize: root.fontSize
    }

    CentreBar {
        anchors.horizontalCenter: parent.horizontalCenter
        height: parent.height
        colBg: root.colBg
        colFg: root.colFg
        colMuted: root.colMuted
        colCyan: root.colCyan
        colBlue: root.colBlue
        colYellow: root.colYellow
        fontFamily: root.fontFamily
        fontSize: root.fontSize
    }

    RightBar {
        anchors.right: parent.right
        height: parent.height

        colBg: root.colBg
        colFg: root.colFg
        colMuted: root.colMuted
        colCyan: root.colCyan
        colBlue: root.colBlue
        colYellow: root.colYellow
        fontFamily: root.fontFamily
        fontSize: root.fontSize
    }
}
