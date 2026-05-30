import "."
import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

ShellRoot {
    id: main
    QtObject {
        id: uiController
        property var rootWindow: root
    }

    IpcHandler {
        target: "TopBar"

        function forceReload() {
            Quickshell.reload(true);
        }
    }

    QtObject {
        id: uiTheme
        property string fontFamily: "JetBrainsMono Nerd Font"
        property int fontSize: 10
    }

    Variants {
        model: Quickshell.screens

        delegate: Component {
            Item {
                required property var modelData

                PanelWindow {
                    screen: modelData

                    anchors.top: true
                    anchors.left: true
                    anchors.right: true
                    margins.top: 5
                    margins.left: 5
                    margins.right: 5

                    color: "transparent"
                    implicitHeight: 30

                    LeftBar {
                        anchors.left: parent.left
                        height: parent.height
                        ui: uiController
                        theme: uiTheme
                    }

                    CentreBar {
                        anchors.horizontalCenter: parent.horizontalCenter
                        height: parent.height
                        ui: uiController
                        theme: uiTheme
                    }

                    RightBar {

                        anchors.right: parent.right
                        height: parent.height
                        ui: uiController
                        theme: uiTheme
                    }
                }

                PanelWindow {
                    anchors {
                        top: true
                        bottom: true
                        left: true
                        right: true
                    }

                    property bool test: false

                    visible: test
                    color: "transparent"

                    WlrLayershell.namespace: "wallpaper-selector-parallel"
                    WlrLayershell.layer: WlrLayer.Overlay
                    WlrLayershell.keyboardFocus: test ? WlrKeyboardFocus.Exclusive : WlrKeyboardFocus.None
                }
            }
        }
    }
}
