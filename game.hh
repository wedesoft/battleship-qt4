#ifndef GAME_HH
#define GAME_HH

#include "player.hh"

class Game
{
public:
    Game(void);
    virtual ~Game(void);
    Player *human(void) { return m_human; }
    Player *computer(void) { return m_computer; }
    void computerMove(void);
protected:
    Player *m_human;
    Player *m_computer;
    bool placing;
};

#endif

