// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause
import QtQuick
import QtInsightTracker

ChoosingCoffeeForm {
    //! [interaction]
    cappuccino.button.onClicked: {
        InsightTracker.interaction(cappuccino.coffeeText.text, cappuccino.InsightCategory.category);

        applicationFlow.cappuccino()
    }
    //! [interaction]
    macchiato.button.onClicked: {
        InsightTracker.interaction(macchiato.coffeeText.text, macchiato.InsightCategory.category);

        applicationFlow.macchiato()
    }
    espresso.button.onClicked: {
        InsightTracker.interaction(espresso.coffeeText.text, espresso.InsightCategory.category);

        applicationFlow.espresso()
    }
    latte.button.onClicked: {
        InsightTracker.interaction(latte.coffeeText.text, latte.InsightCategory.category);

        applicationFlow.latte()
    }
}
