#ifndef GAMEWINDOW_HH
#define GAMEWINDOW_HH

#include <QtGui/QMainWindow>
#include "ui_gamewindow.hh"
#include "boardview.hh"
#include "game.hh"

#define DELAY 3000

class GameWindow: public QMainWindow
{
    Q_OBJECT
public:
    GameWindow(void);
    virtual ~GameWindow(void);
public slots:
    void restart();
    void startGame();
    void computerMove();
    void status(QString);
protected:
    Ui::GameWindow ui;
    Game *m_game;
    BoardView *m_humanBoard;
    BoardView *m_computerBoard;
};

#endif

