from PyQt4.QtGui import QMainWindow
from ui_gamewindow import Ui_GameWindow
from game import Game
class GameWindow(QMainWindow):
  def __init__(self):
    QMainWindow.__init__(self)
    self.game = Game()
    self.ui = Ui_GameWindow()
    self.ui.setupUi(self)
    self.ui.actionNewGame.triggered.connect(self.restart)
    self.ui.actionQuit.triggered.connect(self.close)
    self.ui.startButton.clicked.connect(self.startGame)
  def restart(self):
    self.game = Game()
    self.ui.startButton.setEnabled(True)
  def startGame(self):
    self.game.setPlacing(False)
    self.ui.startButton.setEnabled(False)
  def computerMove(self):
    pass
  def status(text):
    self.statusBar().showMessage(text, DELAY)

