class Player:
  N = 10
  LENGTH = [5, 4, 3, 3, 2]
  TITLE = ['Carrier', 'Battleship', 'Destroyer', 'Submarine', 'Patrol boat']
  RANDOMIZE = 100
  def __init__(self, game):
    self.game = game
    self.ship = [[0, 0, False], [0, 1, False], [0, 2, False], [0, 3, False], [0, 4, False]]
    self.board = [[0 for y in range(1, self.N)] for x in range(1, self.N)]
  def placing(self):
    self.game.placing
  def playing(self):
    not self.placing() and not self.game.over()
  def getShip(self, i):
    return self.ship[i]
  def target(self, x, y):
    self.board[y][x] = True
 
