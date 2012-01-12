#include "game.hh"

Game::Game(void)
{
  m_human = new Player(this);
  m_computer = new Player(this);
  m_placing = true;
}

Game::~Game(void)
{
  delete m_human;
  delete m_computer;
}

void Game::computerMove(void)
{
}

bool Game::over(void)
{
  return false;
}
