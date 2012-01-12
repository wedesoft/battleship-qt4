#include <ctime>
#include <cstdlib>
#include <vector>
#include "game.hh"

using namespace std;

Game::Game(void)
{
  srandom(time(NULL));
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
  vector< pair< int, int> > unknown;
  vector< pair< int, int> > prefer;
  for (int y=0; y<N; y++)
    for (int x=0; x<N; x++)
      if (m_human->board(x, y) == UNKNOWN) {
        unknown.push_back(pair< int, int >(x, y));
        if (m_human->neighbour_hit(x, y))
          prefer.push_back(pair< int, int >(x, y));
      };
  if (prefer.empty()) {
    int idx = random() % unknown.size();
    m_human->target(unknown[idx].first, unknown[idx].second);
  } else {
    int idx = random() % prefer.size();
    m_human->target(prefer[idx].first, prefer[idx].second);
  };
}

bool Game::over(void)
{
  return m_human->defeated() || m_computer->defeated();
}
