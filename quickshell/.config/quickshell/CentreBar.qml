import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

Item {
    id: centreBar

    property color colBg
    property color colFg
    property color colMuted
    property color colCyan
    property color colBlue
    property color colYellow
    property string fontFamily
    property int fontSize

    width: 180

    Rectangle {
        anchors.fill: parent
        opacity: 0.4
        color: colFg
        radius: 10
    }

    RowLayout {
        anchors.fill: parent
        anchors.margins: 6
        spacing: 0

        Rectangle {
            Layout.fillWidth: true
            Layout.preferredWidth: 1
            Layout.fillHeight: true

            color: "transparent"

            Text {
                id: clock
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                color: colMuted
                font {
                    family: centreBar.fontFamily
                    pixelSize: centreBar.fontSize
                    bold: true
                }
            }
        }
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredWidth: 2
            Layout.fillHeight: true

            color: "transparent"

            Text {
                id: date
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                color: colMuted
                font {
                    family: centreBar.fontFamily
                    pixelSize: centreBar.fontSize
                    bold: true
                }
            }
        }
    }
    Scope {
        Process {
            id: clockProcess

            command: ["date", "+%d/%m/%y %H:%M"]
            running: true

            stdout: StdioCollector {
                onStreamFinished: {
                    var output = this.text.trim();
                    var parts = output.split(" ");

                    clock.text = "  " + parts[1];
                    date.text = "  " + parts[0];
                }
            }
        }

        Timer {
            interval: 1000
            running: true
            repeat: true

            onTriggered: clockProcess.running = true
        }
    }
}
