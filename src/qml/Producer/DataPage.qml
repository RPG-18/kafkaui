import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import plumber
import "../Components" as Components

Item {
    property var topicModel
    property alias selectedTopic: topicBox.currentValue
    property alias keyTypeId: keyCbx.typeId
    property alias valueTypeId: valueCbx.typeId
    property alias protoKey: protoKeyId
    property alias protoValue: protoValueId

    function keyData() {
        switch (keyCbx.typeId) {
        case 0:
            return keyArea.text;
        case 6:
            return "";
        case 7:
            return keyArea.text;
        default:
            return keyTxt.text;
        }
    }

    function valueData() {
        switch (valueCbx.typeId) {
        case 0:
            return valueArea.text;
        case 6:
            return "";
        case 7:
            return valueArea.text;
        default:
            return valueTxt.text;
        }
    }

    height: 100
    width: 100

    ProtoOption {
        id: protoKeyId

        file: keyProto.protoFile
        message: keyProto.protoMessage
    }

    ProtoOption {
        id: protoValueId

        file: valueProto.protoFile
        message: valueProto.protoMessage
    }

    GridLayout {
        anchors.fill: parent
        anchors.margins: 8
        anchors.bottomMargin: 0
        columns: 2

        Text {
            text: qsTr("Topic:")
        }

        ComboBox {
            id: topicBox

            model: topicModel
            textRole: "topic"
            valueRole: "topic"
            Layout.preferredWidth: 300
        }

        Text {
            text: qsTr("Key:")
        }

        Components.TypeCombobox {
            id: keyCbx
        }

        TextField {
            id: keyTxt

            Layout.columnSpan: 2
            Layout.fillWidth: true
            selectByMouse: true
            visible: keyCbx.typeId >= 1 && keyCbx.typeId < 6
        }

        ProtobufOptions {
            id: keyProto

            Layout.columnSpan: 2
            Layout.fillWidth: true
            visible: keyCbx.typeId === 7
        }

        Components.TextArea {
            id: keyArea

            Layout.columnSpan: 2
            Layout.fillWidth: true
            Layout.preferredHeight: 200
            visible: keyCbx.typeId === 0 || keyCbx.typeId === 7
        }

        Rectangle {
            Layout.columnSpan: 2
            Layout.fillWidth: true
            height: 1
            color: "#f0f0f0"
        }

        Text {
            text: qsTr("Value:")
        }

        Components.TypeCombobox {
            id: valueCbx
        }

        TextField {
            id: valueTxt

            Layout.columnSpan: 2
            Layout.fillWidth: true
            selectByMouse: true
            visible: valueCbx.typeId >= 1 && valueCbx.typeId < 6
        }

        ProtobufOptions {
            id: valueProto

            Layout.columnSpan: 2
            Layout.fillWidth: true
            visible: valueCbx.typeId === 7
        }

        Components.TextArea {
            id: valueArea

            Layout.columnSpan: 2
            Layout.fillWidth: true
            Layout.fillHeight: true
            visible: valueCbx.typeId === 0 || valueCbx.typeId === 7
        }

        Item {
            visible: !valueArea.visible
            Layout.columnSpan: 2
            Layout.fillHeight: true
        }

    }

}
