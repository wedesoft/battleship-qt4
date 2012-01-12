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
