#ifndef BOARDVIEW_HH
#define BOARDVIEW_HH

#include <vector>
#include <QtGui/QWidget>
#include <QtSvg/QSvgRenderer>
#include "player.hh"

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
  virtual void paintEvent(QPaintEvent *e);
  Player *m_player;
  bool m_visible;
  QSvgRenderer *m_panel;
  QSvgRenderer *m_hit;
  QSvgRenderer *m_miss;
  std::vector<QSvgRenderer *> m_ship;
  int m_moving;
  int m_x0;
  int m_y0;
  int m_dx;
  int m_dy;
};

#endif

