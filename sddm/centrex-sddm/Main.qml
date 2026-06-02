import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import SddmComponents 2.0

Rectangle {
    id: root
    width:  Screen.width
    height: Screen.height
    color:  "#1a1b26"

    // Background wallpaper
    Image {
        anchors.fill: parent
        source: config.background
        fillMode: Image.PreserveAspectCrop
        asynchronous: true
    }

    // Dark overlay
    Rectangle {
        anchors.fill: parent
        color: "#80000000"
    }

    // CentrexOS branding
    Column {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: parent.height * 0.12
        spacing: 8

        Image {
            anchors.horizontalCenter: parent.horizontalCenter
            source: "/usr/share/centrexos/logo-white.svg"
            width:  96
            height: 96
            fillMode: Image.PreserveAspectFit
            smooth: true
        }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text: "CentrexOS"
            color: "#c0caf5"
            font.pixelSize: 32
            font.family: config.font
            font.weight: Font.Bold
        }
    }

    // Login form
    Rectangle {
        id: loginCard
        anchors.centerIn: parent
        width:  360
        height: 280
        radius: 12
        color:  "#1e2030"
        border.color: "#414868"
        border.width: 1

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 28
            spacing: 16

            Text {
                text: userModel.lastUser || "User"
                color: "#c0caf5"
                font.pixelSize: 18
                font.family: config.font
                font.weight: Font.Medium
                Layout.alignment: Qt.AlignHCenter
            }

            TextField {
                id: usernameField
                Layout.fillWidth: true
                placeholderText: "Username"
                text: userModel.lastUser
                color: "#c0caf5"
                placeholderTextColor: "#565f89"
                background: Rectangle {
                    color: "#24283b"
                    radius: 6
                    border.color: usernameField.activeFocus ? "#7aa2f7" : "#414868"
                }
                font.pixelSize: 14
                leftPadding: 12
            }

            TextField {
                id: passwordField
                Layout.fillWidth: true
                placeholderText: "Password"
                echoMode: TextInput.Password
                color: "#c0caf5"
                placeholderTextColor: "#565f89"
                background: Rectangle {
                    color: "#24283b"
                    radius: 6
                    border.color: passwordField.activeFocus ? "#7aa2f7" : "#414868"
                }
                font.pixelSize: 14
                leftPadding: 12
                Keys.onReturnPressed: loginButton.clicked()
            }

            Button {
                id: loginButton
                Layout.fillWidth: true
                text: "Sign In"
                contentItem: Text {
                    text: loginButton.text
                    color: "#1a1b26"
                    font.pixelSize: 14
                    font.weight: Font.Bold
                    horizontalAlignment: Text.AlignHCenter
                }
                background: Rectangle {
                    color: loginButton.hovered ? "#89b4fa" : "#7aa2f7"
                    radius: 6
                }
                onClicked: {
                    sddm.login(usernameField.text, passwordField.text, sessionModel.index(0, 0))
                }
            }
        }
    }

    // Session selector and power buttons
    Row {
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottomMargin: 24
        spacing: 16

        Button {
            text: "Reboot"
            flat: true
            contentItem: Text { text: parent.text; color: "#a9b1d6"; font.pixelSize: 12 }
            onClicked: sddm.reboot()
        }

        Button {
            text: "Power Off"
            flat: true
            contentItem: Text { text: parent.text; color: "#a9b1d6"; font.pixelSize: 12 }
            onClicked: sddm.powerOff()
        }
    }

    Component.onCompleted: {
        if (usernameField.text === "") usernameField.focus = true
        else passwordField.focus = true
    }
}
