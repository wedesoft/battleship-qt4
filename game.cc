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
      };
  int idx = random() % unknown.size();
  m_human->target(unknown[idx].first, unknown[idx].second);
/*
  def computer_move
    unknown = []
    prefer = []
    for y in 0 ... Player::N
      for x in 0 ... Player::N
        if @human.board(x, y) == :unknown
          unknown.push [x, y]
          prefer.push [x, y] if @human.neighbour_hit(x, y)
        end
      end
    end
    unless prefer.empty?
      @human.target *prefer[rand(prefer.size)]
    else
      @human.target *unknown[rand(unknown.size)]
    end
  end
  */
}

bool Game::over(void)
{
  return false;
}
