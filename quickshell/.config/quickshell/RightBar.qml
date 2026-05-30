import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

Item {
    id: rightBar

    property var ui
    property var theme

    width: 450

    property string battery: "100%"
    property string brightness: "100%"
    property string volume: "100%"
    property string network: "disabled"
    property string bluetooth: "disabled"
    property var muted: false

    property color bgColor: Theme.secondary
    property color fgColor: Theme.foreground

    Rectangle {
        anchors.fill: parent
        color: Theme.background
        opacity: 0.75
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

                //Network
                Rectangle {
                    id: networkRect

                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.preferredWidth: 2.5
                    radius: 5
                    color: rightBar.bgColor
                    opacity: 0.75

                    Text {
                        id: networkText
                        anchors.centerIn: parent
                        text: rightBar.network
                        color: rightBar.fgColor

                        font {
                            family: theme.fontFamily
                            pixelSize: theme.fontSize
                            bold: true
                        }
                    }

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true

                        onClicked: {
                            networkToggle.running = true;
                        }
                    }
                }

                //Bluetooth
                Rectangle {
                    id: bluetoothRect
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.preferredWidth: 2.5
                    radius: 5

                    color: rightBar.bgColor
                    opacity: 0.75
                    Text {
                        id: bluetoothText
                        anchors.centerIn: parent
                        text: rightBar.bluetooth
                        color: rightBar.fgColor

                        font {
                            family: theme.fontFamily
                            pixelSize: theme.fontSize
                            bold: true
                        }
                    }

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: {
                            bluetoothToggle.running = true;
                        }
                    }
                }

                //Volume
                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.preferredWidth: 1.2
                    radius: 5

                    color: rightBar.bgColor
                    opacity: 0.75
                    Text {
                        id: volumeText
                        anchors.centerIn: parent
                        color: rightBar.fgColor
                        text: volume

                        font {
                            family: theme.fontFamily
                            pixelSize: theme.fontSize
                            bold: true
                        }
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: audioMute.running = true
                    }
                }

                //Brightness
                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.preferredWidth: 1.2
                    radius: 5

                    color: rightBar.bgColor
                    opacity: 0.75
                    Text {
                        id: brightnessText
                        anchors.centerIn: parent
                        color: rightBar.fgColor
                        text: brightness

                        font {
                            family: theme.fontFamily
                            pixelSize: theme.fontSize
                            bold: true
                        }
                    }
                }

                //Battery
                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.preferredWidth: 1.2
                    radius: 5

                    color: rightBar.bgColor
                    opacity: 0.75
                    Text {
                        id: batteryText
                        anchors.centerIn: parent
                        color: rightBar.fgColor
                        text: battery

                        font {
                            family: theme.fontFamily
                            pixelSize: theme.fontSize
                            bold: true
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
                    family: theme.fontFamily
                    pixelSize: theme.fontSize + 2
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
                            let newVol = (data.volume.toString() + "% " + data.icon).trim();
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
            id: networkFetcher
            running: true
            command: ["zsh", "-c", "~/.config/quickshell/scripts/networkFetcher.sh"]

            stdout: StdioCollector {
                onStreamFinished: {
                    console.log("Fetchign");
                    let txt = this.text.trim();
                    try {
                        if (txt != "") {
                            let data = JSON.parse(txt);
                            if (data.status == "disabled") {
                                rightBar.network = "Network off";
                            } else if (data.ssid == "") {
                                rightBar.network = "Disconnected " + data.icon;
                            } else {
                                rightBar.network = data.ssid + " " + data.icon;
                            }
                        } else {
                            network = "ERROR";
                        }
                    } catch (e) {}
                    networkWaiter.running = false;
                    networkWaiter.running = true;
                }
            }
        }

        Process {
            id: networkWaiter
            command: ["zsh", "-c", "~/.config/quickshell/scripts/networkWaiter.sh"]
            onExited: {
                networkFetcher.running = false;
                networkFetcher.running = true;
            }
        }

        Process {
            id: networkToggle
            command: ["zsh", "-c", "~/.config/quickshell/scripts/networkFetcher.sh --toggle"]
            running: false
        }

        Process {
            id: bluetoothToggle
            command: ["zsh", "-c", "/home/fenrir/.config/quickshell/scripts/bluetoothFetcher.sh --toggle"]
            running: false
        }

        Process {
            id: bluetoothFetcher
            command: ["zsh", "-c", "/home/fenrir/.config/quickshell/scripts/bluetoothFetcher.sh"]
            running: true

            stdout: StdioCollector {
                onStreamFinished: {
                    let txt = this.text.trim();
                    try {
                        if (txt != "") {
                            let data = JSON.parse(txt);
                            if (data.status == "off") {
                                rightBar.bluetooth = "Bluetooth off";
                            } else if (data.connected == "Disconnected") {
                                rightBar.bluetooth = "Disconnected";
                            } else {
                                rightBar.bluetooth = data.connected + " " + data.icon;
                            }
                        } else {
                            rightBar.bluetooth = "ERROR";
                        }
                        rightBar.bluetooth = data.connected;
                        console.log("BT " + data.connected);
                    } catch (e) {}
                    bluetoothWaiter.running = false;
                    bluetoothWaiter.running = true;
                }
            }
        }
        Process {
            id: bluetoothWaiter
            command: ["zsh", "-c", "/home/fenrir/.config/quickshell/scripts/bluetoothWaiter.sh"]

            onExited: {
                bluetoothFetcher.running = false;
                bluetoothFetcher.running = true;
            }
        }
    }
}
