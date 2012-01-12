#include <QtGui/QMainWindow>
#include "ui_gamewindow.hh"

class GameWindow: public QMainWindow
{
public:
    GameWindow(void);
protected:
    Ui::GameWindow ui;
};

