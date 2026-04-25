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

    property int cpuUsage: 0
    property int memUsage: 0
    property int temprature: 0
    property int battery: 0
    property int brightness: 0
    property int volume: 0
    property var muted: false

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

                    color: colYellow
                    opacity: 0.5
                    Text {
                        id: cpuText

                        anchors.centerIn: parent
                        text: cpuUsage + "%"

                        font {
                            family: rightBar.fontFamily
                            pixelSize: rightBar.fontSize
                        }
                    }
                }
                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    radius: 5

                    color: colYellow
                    opacity: 0.5
                    Text {
                        id: memText
                        anchors.centerIn: parent
                        text: memUsage + "%"

                        font {
                            family: rightBar.fontFamily
                            pixelSize: rightBar.fontSize
                        }
                    }
                }
                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    radius: 5

                    color: colYellow
                    opacity: 0.5
                    Text {
                        id: tempText
                        anchors.centerIn: parent
                        text: temprature + "*C"

                        font {
                            family: rightBar.fontFamily
                            pixelSize: rightBar.fontSize
                        }
                    }
                }
                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    radius: 5

                    color: colYellow
                    opacity: 0.5
                    Text {
                        id: volumeText
                        anchors.centerIn: parent
                        text: volume + "V"

                        font {
                            family: rightBar.fontFamily
                            pixelSize: rightBar.fontSize
                        }
                    }
                }
                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    radius: 5

                    color: colYellow
                    opacity: 0.5
                    Text {
                        id: brightnessText
                        anchors.centerIn: parent
                        text: brightness + "L"

                        font {
                            family: rightBar.fontFamily
                            pixelSize: rightBar.fontSize
                        }
                    }
                }
                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    radius: 5

                    color: colYellow
                    opacity: 0.5
                    Text {
                        id: batteryText
                        anchors.centerIn: parent
                        text: battery + "B"

                        font {
                            family: rightBar.fontFamily
                            pixelSize: rightBar.fontSize
                        }
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

    Scope {
        Process {
            id: batteryPoller
        }
        Process {
            id: batteryWaiter
        }
    }
}
