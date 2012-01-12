#include "game.hh"
#include "player.hh"

Player::Player(Game *game): m_game(game)
{
}

bool Player::placing(void)
{
  return m_game->placing();
}

bool Player::defeated(void)
{
}
