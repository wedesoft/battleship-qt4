#ifndef BOARDVIEW_HH
#define BOARDVIEW_HH

#include <QtGui/QWidget>
#include <QtSvg/QSvgRenderer>
#include "player.hh"

#define PANEL ":/images/panel.svg"
#define HIT ":/images/hit.svg"
#define MISS ":/images/miss.svg"

class BoardView: public QWidget
{
    Q_OBJECT
public:
    BoardView(Player *player, bool visible, QWidget *parent = 0);
    void setBoard(Player *player);
signals:
    void message(QString);
    void computerMove(void);
protected:
    Player *m_player;
    bool m_visible;
    QSvgRenderer *m_panel;
    QSvgRenderer *m_hit;
    QSvgRenderer *m_miss;
};

#endif

