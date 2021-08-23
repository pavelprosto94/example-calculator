/*  CalculatorButton.qml */
import QtQuick 2.7
import Ubuntu.Components 1.3

Rectangle {
    property alias text: label.text
    signal clicked 

    color: "#AEA79F"
    radius: units.gu(1)
    border.width: units.gu(0.25)
    border.color: backgroundColor

    property alias color_text: label.color
    Label {
        id: label
        font.pixelSize: units.gu(4)
        anchors.centerIn: parent
        color: "#111"
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: parent.clicked()
    }
}
