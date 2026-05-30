import "."
import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

Item {
    id: centreBar

    property var rootWindow
    property var ui
    property var theme

    width: 180

    Rectangle {
        id: centreTrigger
        anchors.fill: parent
        opacity: 0.75

        color: Theme.background
        radius: 10

        MouseArea {
            id: centreTriggerMouse
            anchors.fill: parent
            hoverEnabled: true
        }
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
                color: Theme.on_background
                font {
                    family: theme.fontFamily
                    pixelSize: 13
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
                color: Theme.on_background
                font {
                    family: theme.fontFamily

                    pixelSize: 13
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
        Timer {
            id: hoverDelay
            interval: 300
            running: false
            repeat: false

            onTriggered: controller.centreBarHovered = false
        }
    }
}
