#ifndef PLAYER_HH
#define PLAYER_HH

class Game;

#define N 10

class Player
{
public:
  Player(Game *game);
  bool defeated(void);
  bool placing(void);
protected:
  Game *m_game;
};

#endif
