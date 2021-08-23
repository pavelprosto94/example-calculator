import QtQuick 2.7
import Ubuntu.Components 1.3
//import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0
import io.thp.pyotherside 1.3
import "./"

MainView {
    id: root
    objectName: 'mainView'
    applicationName: 'example-calculator.yourname'
    automaticOrientation: true

    width: units.gu(45)
    height: units.gu(75)

    Page {
        anchors.fill: parent

        header: PageHeader {
            id: header
            title: i18n.tr('Calculator')
        }

        TextField {
        id: textField
        text: ""
        
        property bool hasError: false
        font.italic: hasError
        anchors {
            topMargin: units.gu(1);
            top: header.bottom
            left: parent.left
            leftMargin: units.gu(1);
            right: parent.right
            rightMargin: units.gu(1);
        }

        height: units.gu(8)
        font.pixelSize: units.gu(4)
        }
        
        Grid {
            anchors { 
                top: textField.bottom
                left: parent.left
                right: parent.right
                bottom: parent.bottom
            }
            columns: 4
            rows: 4
            Repeater {
                model: ["/", 1, 2, 3, "*", 4, 5, 6, "-", 7, 8, 9, "+", ".", 0]
                delegate: CalculatorButton {
                    text: modelData.toString ()
                    height: parent.height / parent.rows
                    width: parent.width / parent.columns
                    color: {
                    if ((index % 4 == 0) || (modelData.toString() == "."))
                        {
                            color_text = "white"
                            return "#E95420"
                        } else {
                            return "#AEA79F"
                        }
                    }
                    onClicked: textField.text += modelData.toString()
                }
            }
            CalculatorButton {
                    text: "="
                    color: "#5E2750"
                    color_text : "white"
                    height: parent.height / parent.rows
                    width: parent.width / parent.columns
                    onClicked: {
                        python.call("example.calculate", [ textField.text ], function ( result ) {
                        var isValid = result[0];
                        if (isValid) {
                        textField.hasError =false
                        textField.text = result[1];
                        } else {
                        textField.hasError =true  
                        }
                    })
                    }
            }
        }     
        Python {
            id: python

            Component.onCompleted: {
                addImportPath(Qt.resolvedUrl('../src/'));
            importModule_sync("example")
            }

            onError: {
                console.log('python error: ' + traceback);
            }
        }
    }
}
