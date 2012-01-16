#include <QtGui/QApplication>
#include "gamewindow.hh"

int main(int argc, char *argv[])
{
  QApplication app(argc, argv, QApplication::GuiClient);
  // app.setStyle("windows");
  // app.setStyle("macintosh");
  app.setStyle("plastique");
  GameWindow window;
  window.show();
  return app.exec();
};


