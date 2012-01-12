#include "boardview.hh"

BoardView::BoardView(Player *player, bool visible, QWidget *parent)
{
  m_player = player;
}

void BoardView::setBoard(Player *player)
{
  m_player = player;
  update();
}
