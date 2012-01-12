#include <QtGui/QApplication>
#include "gamewindow.hh"

int main(int argc, char *argv[])
{
  QApplication app(argc, argv, QApplication::GuiClient);
  GameWindow window;
  window.show();
  return app.exec();
};


