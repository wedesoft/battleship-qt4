#include "boardview.hh"

BoardView::BoardView(Player *player, bool visible, QWidget *parent):
  QWidget(parent), m_player(player), m_visible(visible)
{
  m_panel = new QSvgRenderer(QString(PANEL), this);
  m_hit = new QSvgRenderer(QString(HIT), this);
  m_miss = new QSvgRenderer(QString(MISS), this);
}

  /* 
  SHIPS = [':/images/carrier.svg', ':/images/battleship.svg', ':/images/destroyer.svg',
           ':/images/submarine.svg', ':/images/patrol boat.svg']

  def initialize(player, visible, parent = nil)
    @panel = Qt::SvgRenderer.new PANEL
    @hit = Qt::SvgRenderer.new HIT
    @miss = Qt::SvgRenderer.new MISS
    @ship = SHIPS.collect { |filename| Qt::SvgRenderer.new filename }
    @moving, @x0, @y0, @dx, @dy = nil, 0, 0, 0, 0
  end
*/

void BoardView::setBoard(Player *player)
{
  m_player = player;
  update();
}
