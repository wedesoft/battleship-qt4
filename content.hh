#ifndef CONTENT_HH
#define CONTENT_HH

#include <QtGui/QWidget>
#include "ui_content.hh"
#include "boardview.hh"
#include "game.hh"

class Content: public QWidget
{
    Q_OBJECT
public:
    Content(Game *game, QWidget *parent = 0);
    BoardView *humanBoard(void) { return m_humanBoard; }
    BoardView *computerBoard(void) { return m_computerBoard; }
    void setGame(Game *game);
signals:
    void message(QString);
public slots:
    void computerMove();
protected:
    Ui::Content ui;
    Game *m_game;
    BoardView *m_humanBoard;
    BoardView *m_computerBoard;
};

#endif

