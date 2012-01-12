#include "game.hh"

Game::Game(void)
{
  m_human = new Player;
  m_computer = new Player;
  placing = true;
}

Game::~Game(void)
{
  delete m_human;
  delete m_computer;
}

void Game::computerMove(void)
{
}

