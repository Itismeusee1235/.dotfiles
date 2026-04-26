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

    property string temprature: "100"
    property string battery: "100%"
    property string brightness: "100%"
    property string volume: "100%"
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
                        id: tempText
                        anchors.centerIn: parent
                        text: temprature

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
                        text: volume

                        font {
                            family: rightBar.fontFamily
                            pixelSize: rightBar.fontSize
                        }
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: audioMute.running = true
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
                        text: brightness

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
                        text: battery

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
            running: true
            command: ["zsh", "-c", "~/.config/quickshell/scripts/batteryFetcher.sh"]

            stdout: StdioCollector {
                onStreamFinished: {
                    let txt = this.text.trim();
                    if (txt != "") {
                        try {
                            let data = JSON.parse(txt);
                            let newBat = data.percent.toString() + "% " + data.icon;
                            if (rightBar.battery !== newBat)
                                rightBar.battery = newBat;
                        } catch (e) {}
                    }
                    batteryWaiter.running = false;
                    batteryWaiter.running = true;
                }
            }
        }
        Process {
            id: batteryWaiter
            command: ["zsh", "-c", "~/.config/quickshell/scripts/batteryWatcher.sh"]

            onExited: {
                batteryPoller.running = false;
                batteryPoller.running = true;
            }
        }

        Process {
            id: audioFetcher
            running: true
            command: ["zsh", "-ic", "~/.config/quickshell/scripts/audioFetcher.sh"]

            stdout: StdioCollector {
                onStreamFinished: {
                    let text = this.text.trim();

                    if (text != "") {
                        try {
                            let data = JSON.parse(text);
                            let newVol = data.volume.toString() + "% " + data.icon;
                            if (newVol !== rightBar.volume)
                                rightBar.volume = newVol;
                        } catch (e) {}
                    }
                    audioWaiter.running = false;
                    audioWaiter.running = true;
                }
            }
        }
        Process {
            id: audioWaiter
            command: ["zsh", "-c", "/home/fenrir/.config/quickshell/scripts/audioWatcher.sh"]

            onExited: {
                audioFetcher.running = false;
                audioFetcher.running = true;
            }
        }

        Process {
            id: audioMute
            command: ["zsh", "-c", "~/.config/quickshell/scripts/audioFetcher.sh --toggle"]
        }

        Process {
            id: brightnessFetcher
            command: ["zsh", "-c", "~/.config/quickshell/scripts/brightnessFetcher.sh"]
            running: true

            stdout: StdioCollector {
                onStreamFinished: {
                    let txt = this.text.trim();
                    try {
                        if (txt != "") {
                            let data = JSON.parse(txt);
                            let newBri = data.percent + "% " + data.icon;
                            if (rightBar.brightness !== newBri)
                                rightBar.brightness = newBri;
                        }
                    } catch (e) {}
                    brightnessWaiter.running = false;
                    brightnessWaiter.running = true;
                }
            }
        }
        Process {
            id: brightnessWaiter
            command: ["zsh", "-c", "~/.config/quickshell/scripts/brightnessWatcher.sh"]
            onExited: {
                brightnessFetcher.running = false;
                brightnessFetcher.running = true;
            }
        }

        Process {
            id: tempFetcher
            command: ["zsh", "-c", "~/.config/quickshell/scripts/tempFetcher.sh"]
            running: true

            stdout: StdioCollector {
                onStreamFinished: {
                    let txt = this.text.trim();
                    rightBar.temprature = " " + txt;
                }
            }
        }

        Timer {
            interval: 1000
            running: true
            repeat: true

            onTriggered: {
                tempFetcher.running = true;
            }
        }
    }
}
