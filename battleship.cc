#include <QtGui/QApplication>
#include "gamewindow.hh"

int main(int argc, char *argv[])
{
  QApplication app(argc, argv);
  GameWindow window;
  window.show();
  return app.exec();
};


