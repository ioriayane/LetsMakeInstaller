#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtCore/QTranslator>

int main(int argc, char *argv[])
{
#if defined(Q_OS_WIN)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);

    //フォルダパスの作成                   [1]
    QString dir = QString("%1/translations")
            .arg(QCoreApplication::applicationDirPath());

    //アプリの翻訳データ登録                [2]
    QTranslator translator;
    translator.load(QString("%1_%2")
                    .arg(QCoreApplication::applicationName())
                    .arg(QLocale::system().name())
                    , dir);
    app.installTranslator(&translator);

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
