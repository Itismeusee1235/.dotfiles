import QtQuick
import Quickshell
import QtQuick.Layouts
import Quickshell.Hyprland
import Quickshell.Io

Item {
    id: leftBar

    width: 245

    property var ui
    property var theme

    Rectangle {
        anchors.fill: parent
        opacity: 0.75
        color: Theme.background
        radius: 10
    }

    RowLayout {
        anchors.centerIn: parent
        anchors.margins: 4
        spacing: 3

        Rectangle {
            implicitHeight: 20
            implicitWidth: 20

            color: Theme.primary
            radius: 5

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    ffLauncher.running = true;
                }
            }

            Text {
                anchors.centerIn: parent
                color: Theme.on_primary
                text: " "

                font {
                    family: theme.fontFamily
                    pixelSize: theme.fontSize
                    bold: true
                }
            }
        }

        // Workspaces
        Repeater {
            model: 9
            Item {
                Layout.preferredWidth: 20
                Layout.preferredHeight: 20

                property var ws: Hyprland.workspaces.values.find(w => w.id === index + 1)
                property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)

                property color bgColor: isActive ? Theme.primary : (ws ? Theme.secondary : Theme.tertiary)
                property color fgColor: isActive ? Theme.on_primary : (ws ? Theme.on_secondary : Theme.on_tertiary)
                property bool isHovered: (mouseArea.containsMouse)

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
                    color: isHovered ? Theme.error : bgColor
                    opacity: ws ? 0.8 : 0.3
                    radius: 5
                    Text {
                        anchors.centerIn: parent

                        text: index + 1
                        color: fgColor
                        font {
                            family: theme.fontFamily
                            pixelSize: theme.fontSize
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
