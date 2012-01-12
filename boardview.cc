#include <QtGui/QPainter>
#include "boardview.hh"

using namespace std;

#define PANEL ":/images/panel.svg"
#define HIT ":/images/hit.svg"
#define MISS ":/images/miss.svg"
const char *SHIP[5] = {":/images/carrier.svg", ":/images/battleship.svg",
                       ":/images/destroyer.svg", ":/images/submarine.svg",
                       ":/images/patrol boat.svg"};

BoardView::BoardView(Player *player, bool visible, QWidget *parent):
  QWidget(parent), m_player(player), m_visible(visible)
{
  m_panel = new QSvgRenderer(QString(PANEL), this);
  m_hit = new QSvgRenderer(QString(HIT), this);
  m_miss = new QSvgRenderer(QString(MISS), this);
  for (int i=0; i<5; i++)
    m_ship.push_back(new QSvgRenderer(QString(SHIP[i])));
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
}

