#include "game.hh"
#include "player.hh"

Player::Player(Game *game): m_game(game)
{
  for (int j=0; j<N; j++)
    for (int i=0; i<N; i++)
      m_board[j][i] = false;
  for (int i=0; i<COUNT; i++) {
    m_ship[i].x = 0;
    m_ship[i].y = i;
    m_ship[i].vertical = false;
  };
}

bool Player::placing(void)
{
  return m_game->placing();
}

bool Player::defeated(void)
{
}

int Player::board(int x, int y)
{
  if (m_board[y][x])
    if (shipAt(x, y))
      return HIT;
    else
      return MISS;
  else
    return UNKNOWN;
};

bool Player::shipAt(int x, int y)
{
  return false;
}

