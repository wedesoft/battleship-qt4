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

bool Player::gameOver(void)
{
  return false;
}

void Player::target(int x, int y)
{
  m_game->setPlacing(false);
  m_board[y][x] = true;
}

bool Player::defeated(void)
{
  return false;
}

int Player::board(int x, int y)
{
  if (m_board[y][x])
    if (shipAt(x, y) != -1)
      return HIT;
    else
      return MISS;
  else
    return UNKNOWN;
};

bool Player::place(int i, int x, int y, bool vertical)
{
  Ship previous = m_ship[i];
  m_ship[i].x = x;
  m_ship[i].y = y;
  m_ship[i].vertical = vertical;
  bool ok = valid();
  if (!ok)
    m_ship[i] = previous;
  return ok;
}

bool Player::valid(void)
{
  bool retVal = true;
  for (int i1=0; i1<COUNT; i1++) {
    int x1 = m_ship[i1].x;
    int y1 = m_ship[i1].y;
    bool vertical1 = m_ship[i1].vertical;
    int w1 = vertical1 ? 1 : LENGTH[i1];
    int h1 = vertical1 ? LENGTH[i1] : 1;
    if (x1 < 0 || y1 < 0 || x1 + w1 > N || y1 + h1 > N)
      retVal = false;
    for (int i2=0; i2<COUNT; i2++) {
      if (i1 != i2) {
        int x2 = m_ship[i2].x;
        int y2 = m_ship[i2].y;
        bool vertical2 = m_ship[i2].vertical;
        int w2 = vertical2 ? 1 : LENGTH[i2];
        int h2 = vertical2 ? LENGTH[i2] : 1;
        if (x1 + w1 > x2 && x1 < x2 + w2 && y1 + h1 > y2 && y1 < y2 + h2)
          retVal = false;
      };
    };
  };
  return retVal;
}

int Player::shipAt(int bx, int by)
{
  int retVal = -1;
  for (int i=0; i<COUNT; i++) {
    int x = m_ship[i].x;
    int y = m_ship[i].y;
    bool vertical = m_ship[i].vertical;
    int length = LENGTH[i];
    if (!vertical) {
      if (bx >= x && bx < x + length && by == y)
        retVal = i;
    } else {
      if (bx == x && by >= y && by < y + length)
        retVal = i;
    };
  };
  return retVal;
}

