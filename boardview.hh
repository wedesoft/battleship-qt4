#ifndef BOARDVIEW_HH
#define BOARDVIEW_HH

#include <QtGui/QWidget>
#include "player.hh"

class BoardView: public QWidget
{
    Q_OBJECT
public:
    BoardView(Player *player, bool visible, QWidget *parent = 0);
signals:
    void message(QString);
};

#endif

