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
    void setPlacing(bool value) { m_placing = value; }
    bool placing(void) { return m_placing; }
    void computerMove(void);
    bool over(void);
protected:
    Player *m_human;
    Player *m_computer;
    bool m_placing;
};

#endif

