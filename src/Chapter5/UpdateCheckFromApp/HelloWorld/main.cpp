#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include "maintenancetool.h"

int main(int argc, char *argv[])
{
#if defined(Q_OS_WIN)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);

    //メンテナンス機能をQMLタイプとして登録
    qmlRegisterType<MaintenanceTool>("com.example.plugin.maintenancetool"
                                 , 1, 0, "MaintenanceTool");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
