#ifndef PLAYER_HH
#define PLAYER_HH

class Game;

#define N 10
#define COUNT 5
#define UNKNOWN 0
#define HIT 1
#define MISS 2

static const int LENGTH[5] = {5, 4, 3, 3, 2};
static const char *TITLE[5] = {"Carrier", "Battleship", "Destroyer",
                               "Submarine", "Patrol boat"};

typedef struct {
  int x;
  int y;
  bool vertical;
} Ship;

class Player
{
public:
  Player(Game *game);
  bool defeated(void);
  bool placing(void);
  Ship ship(int i) { return m_ship[i]; }
  int board(int x, int y);
  bool place(int i, int x, int y, bool vertical);
  bool valid(void);
  int shipAt(int x, int y);
protected:
  Game *m_game;
  bool m_board[N][N];
  Ship m_ship[COUNT];
};

#endif
