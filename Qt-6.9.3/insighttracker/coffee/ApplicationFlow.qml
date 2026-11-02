// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause
import QtQuick
import QtInsightTracker

ApplicationFlowForm {
    id: applicationFlow
    state: "Home"
    property int animationDuration: 400
    property string platform: Qt.platform.os
    property string mode: ""
    property int brewTime
    property int coffeeAmount
    property int milkAmount
    property int foamAmount
    property double sugarAmount

    //! [transition]
    onStateChanged: InsightTracker.transition(applicationFlow.state);
    //! [transition]

    //! [interaction]
    function themeButton() {
        if (Colors.currentTheme == Colors.dark) {
            Colors.currentTheme = Colors.light
        } else {
            Colors.currentTheme = Colors.dark
        }

        InsightTracker.interaction("theme", "dark theme", Colors.currentTheme == Colors.dark);
    }
    //! [interaction]
    function cappuccino() {
        applicationFlow.state = "Settings"
        applicationFlow.coffeeName = "Cappuccino"
        coffeeAmount = 60
        milkAmount = 60
        foamAmount = 60
        brewTime = 5000
        stack.push(settings)
        coffeeText.text = "Cappuccino"
    }
    function espresso() {
        applicationFlow.state = "Settings"
        applicationFlow.coffeeName = "Espresso"
        coffeeAmount = 80
        milkAmount = 0
        foamAmount = 0
        brewTime = 4000
        stack.push(settings)
        coffeeText.text = "Espresso"
    }
    function latte() {
        applicationFlow.state = "Settings"
        applicationFlow.coffeeName = "Latte"
        coffeeAmount = 40
        milkAmount = 20
        foamAmount = 60
        brewTime = 6000
        stack.push(settings)
        coffeeText.text = "Latte"
    }
    function macchiato() {
        applicationFlow.state = "Settings"
        applicationFlow.coffeeName = "Macchiato"
        coffeeAmount = 100
        milkAmount = 5
        foamAmount = 10
        brewTime = 8000
        stack.push(settings)
        coffeeText.text = "Macchiato"
    }
    //! [On clicked]
    home.getStartedbutton.onClicked: {
        InsightTracker.interaction("start");

        applicationFlow.state = "Coffee-selection"
        stack.push(choosingCoffee)
    }
    //! [On clicked]
    function backButton() {
        InsightTracker.interaction("back");

        stack.pop()
        applicationFlow.state = applicationFlow.previousState
    }
    function confirmButton() {
        InsightTracker.interaction("confirm");

        stack.push(insert)
        applicationFlow.state = "Insert"
    }
    function continueButton() {
        InsightTracker.interaction("continue");

        stack.push(progress)
        applicationFlow.state = "Progress"
        applicationFlow.progressBarValue = 1
        applicationFlow.progressCupState = "1"
        if (applicationFlow.coffeeName == "Cappuccino") {
            applicationFlow.cappuccinos = applicationFlow.cappuccinos - 1
        } else if (applicationFlow.coffeeName == "Espresso") {
            applicationFlow.espressos = applicationFlow.espressos - 1
        } else if (applicationFlow.coffeeName == "Latte") {
            applicationFlow.lattes = applicationFlow.lattes - 1
        } else {
            applicationFlow.macchiatos = applicationFlow.macchiatos - 1
        }
    }
    function cancelButton() {
        InsightTracker.interaction("cancel");

        applicationFlow.state = "Coffee-selection"
        stack.pop(stack.get(1))
    }
    //! [dimension]
    function onFinished() {
        InsightTracker.dimensionData("CoffeeType", coffeeText.text);
        InsightTracker.contextData("milk", applicationFlow.milkAmount);
        InsightTracker.contextData("sugar", applicationFlow.sugarAmount);
        InsightTracker.contextData("coffee", applicationFlow.coffeeName);

        stack.push(ready)
        applicationFlow.state = "Ready"
    }
    //! [dimension]
    //! [new session]
    function onReturnToStart() {
        stack.pop(stack.get(0))
        applicationFlow.state = "Home"
        applicationFlow.progressBarValue = 0
        applicationFlow.progressCupState = "0"

        InsightTracker.startNewSession();
    }
    //! [new session]
    //! [States]
    states: [
        State {
            name: "Home"
            PropertyChanges {
                target: toolbar
                backButton.opacity: 0
                backButton.enabled: false
                themeButton.opacity: 0
                themeButton.enabled: false
                logo.sourceSize.width: 70
                logo.sourceSize.height: 50
            }
            //! [States]
            PropertyChanges {
                target: coffeeText
                visible: false
            }
            PropertyChanges {
                target: stack
                anchors.top: coffeeText.bottom
            }
        },
        State {
            name: "Coffee-selection"
            PropertyChanges {
                target: applicationFlow
                previousState: "Home"

            }
            PropertyChanges {
                target: coffeeText
                text: "Coffee Selection"
            }
            PropertyChanges {
                target: toolbar
                backButton.opacity: 0
                backButton.enabled: false
            }
            PropertyChanges {
                target: stack
                anchors.top: coffeeText.bottom
            }
        },
        State {
            name: "Settings"
            PropertyChanges {
                target: applicationFlow
                previousState: "Coffee-selection"
            }
            PropertyChanges {
                target: stack
                anchors.top: coffeeText.bottom
            }
        },
        State {
            name: "Insert"
            PropertyChanges {
                target: applicationFlow
                previousState: "Settings"
            }
            PropertyChanges {
                target: stack
                anchors.top: coffeeText.bottom
            }
        },
        State {
            name: "Progress"
            PropertyChanges {
                target: applicationFlow
                previousState: "Insert"

            }
            PropertyChanges {
                target: toolbar
                backButton.opacity: 0
                backButton.enabled: false
            }
            PropertyChanges {
                target: stack
                anchors.top: coffeeText.bottom
            }
        },
        State {
            name: "Ready"
            PropertyChanges {
                target: applicationFlow
                previousState: "Progress"

            }
            PropertyChanges {
                target: toolbar
                backButton.opacity: 0
                backButton.enabled: false
            }
            PropertyChanges {
                target: stack
                anchors.top: coffeeText.bottom
            }
        }

    ]
}
