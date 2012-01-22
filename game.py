from player import Player
class Game:
  def __init__(self):
    self.human = Player(self)
    self.computer = Player(self)
    self.placing = True
  def setPlacing(self, value):
    self.placing = value

