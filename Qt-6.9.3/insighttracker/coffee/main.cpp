// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtCore/QLoggingCategory>
#include <QtInsightTracker/QInsightTracker>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    app.setApplicationVersion(QLatin1String(qVersion()));

    QLoggingCategory::setFilterRules("qt.insight*=true");

    QInsightTracker tracker;
    tracker.setEnabled(false);
    tracker.configuration()->setSyncInterval(60);

    QQmlApplicationEngine engine;
    engine.load(QUrl(QLatin1String("qrc:/qt/qml/demos/coffee/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

//! [transition]
    tracker.transition("Home");
//! [transition]

    return app.exec();
}
