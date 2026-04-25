import QtQuick
import Quickshell
import QtQuick.Layouts
import Quickshell.Hyprland
import Quickshell.Io

Item {
    id: leftBar

    property color colBg
    property color colFg
    property color colMuted
    property color colCyan
    property color colBlue
    property color colYellow
    property string fontFamily
    property int fontSize

    width: 245

    Rectangle {
        anchors.fill: parent
        opacity: 0.4
        color: colFg
        radius: 10
    }

    RowLayout {
        anchors.fill: parent
        anchors.margins: 4
        spacing: 3

        Rectangle {
            implicitHeight: 20
            implicitWidth: 20

            color: colYellow
            radius: 5

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    ffLauncher.running = true;
                }
            }

            Text {
                anchors.centerIn: parent
                color: colMuted
                text: " "
            }
        }

        // Workspaces
        Repeater {
            model: 9
            Item {
                Layout.preferredWidth: (mouseArea.containsMouse ? 30 : 20)
                Layout.preferredHeight: 20

                Behavior on Layout.preferredWidth {
                    NumberAnimation {
                        duration: 120
                        easing: Easing.OutQuart
                    }
                }

                property var ws: Hyprland.workspaces.values.find(w => w.id === index + 1)
                property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)

                Rectangle {
                    anchors.centerIn: parent
                    width: 15
                    height: 15
                    opacity: 0

                    MouseArea {
                        id: mouseArea
                        anchors.fill: parent
                        onClicked: Hyprland.dispatch("workspace " + (index + 1))

                        hoverEnabled: true
                    }
                }

                Rectangle {
                    anchors.fill: parent
                    color: colYellow
                    opacity: ws ? 0.8 : 0.3
                    radius: 5
                    Text {
                        anchors.centerIn: parent

                        text: index + 1
                        color: isActive ? root.colCyan : (ws ? root.colBlue : root.colMuted)
                        font {
                            family: root.fontFamily
                            pixelSize: root.fontSize
                            bold: true
                        }
                    }
                }
            }
        }

        Item {
            Layout.fillWidth: true
        }
    }

    Process {
        id: ffLauncher
        command: ["kitty", "-e", "zsh", "-ic", "ff; exec zsh"]
    }
}
