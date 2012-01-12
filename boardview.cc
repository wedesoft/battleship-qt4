#include <QtGui/QPainter>
#include "boardview.hh"

using namespace std;

#define PANELFILE ":/images/panel.svg"
#define HITFILE ":/images/hit.svg"
#define MISSFILE ":/images/miss.svg"
static const char *SHIPFILE[5] = {":/images/carrier.svg", ":/images/battleship.svg",
                                  ":/images/destroyer.svg", ":/images/submarine.svg",
                                  ":/images/patrol boat.svg"};

BoardView::BoardView(Player *player, bool visible, QWidget *parent):
  QWidget(parent), m_player(player), m_visible(visible)
{
  m_panel = new QSvgRenderer(QString(PANELFILE), this);
  m_hit = new QSvgRenderer(QString(HITFILE), this);
  m_miss = new QSvgRenderer(QString(MISSFILE), this);
  for (int i=0; i<5; i++)
    m_ship.push_back(new QSvgRenderer(QString(SHIPFILE[i])));
  m_moving = -1;
  m_x0 = 0;
  m_y0 = 0;
  m_dx = 0;
  m_dy = 0;
}

void BoardView::setBoard(Player *player)
{
  m_player = player;
  update();
}

void BoardView::paintEvent(QPaintEvent *e)
{
  int w = width() / N;
  int h = height() / N;
  QPainter *painter = new QPainter(this);
  for (int j=0; j<N; j++)
    for (int i=0; i<N; i++)
      m_panel->render(painter, QRectF(i * w, j * h, w, h));
  if (m_visible) {
    for (int i=0; i<COUNT; i++) {
      QSvgRenderer *ship = m_ship[i];
      int x = m_player->ship(i).x;
      int y = m_player->ship(i).y;
      bool vertical = m_player->ship(i).vertical;
      int dx, dy;
      if (i != m_moving) {
        dx = 0;
        dy = 0;
      } else {
        dx = m_dx;
        dy = m_dy;
      };
      if (!vertical) {
        QTransform transform;
        painter->setTransform(transform);
        ship->render(painter, QRectF(x * w + dx, y * h + dy, w * LENGTH[i], h));
      } else {
        QTransform transform(0, 1, 1, 0, 0, 0);
        painter->setTransform(transform);
        ship->render(painter, QRectF(y * h + dy, x * w + dx, h * LENGTH[i], w));
      };
    };
  };
  for (int j=0; j<N; j++)
    for (int i=0; i<N; i++) {
      int state = m_player->board(i, j);
      if (state == HIT)
        m_hit->render(painter, QRectF(i * w, j * h, w, h));
      else if (state == MISS)
        m_miss->render(painter, QRectF(i * w, j * h, w, h));
    };
}

