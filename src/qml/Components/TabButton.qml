import QtQuick
import QtQuick.Controls as Controls
import "../style.js" as Style

Controls.TabButton {
    id: control

    background: Rectangle {
        implicitWidth: 120
        implicitHeight: 44
        color: control.hovered ? Style.LightGray : "white"
    }

}
