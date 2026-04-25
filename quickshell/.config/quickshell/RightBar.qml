import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

Item {
    id: rightBar

    property color colBg
    property color colFg
    property color colMuted
    property color colCyan
    property color colBlue
    property color colYellow
    property string fontFamily
    property int fontSize

    width: 300

    Rectangle {
        anchors.fill: parent
        opacity: 0.4
        color: colFg
        radius: 10
    }

    RowLayout {
        anchors.fill: parent
        anchors.margins: 5
        spacing: 5

        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true
            RowLayout {
                anchors.fill: parent
                spacing: 5

                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    radius: 5
                    Text {
                        id: cpu
                    }
                }
                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    radius: 5
                    Text {
                        id: mem
                    }
                }
                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    radius: 5
                    Text {
                        id: temp
                    }
                }
                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    radius: 5
                    Text {
                        id: sound
                    }
                }
                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    radius: 5
                    Text {
                        id: brightness
                    }
                }
                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    radius: 5
                    Text {
                        id: battery
                    }
                }
            }
        }
        Rectangle {
            Layout.preferredWidth: 20
            Layout.fillHeight: true
            radius: 5

            Text {
                id: power
                anchors.centerIn: parent
                text: "󰐥"
                font {
                    family: rightBar.fontFamily
                    pixelSize: rightBar.fontSize
                }
            }
        }
    }
}
