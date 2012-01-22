from PyQt4.QtGui import QHBoxLayout, QMainWindow
from ui_gamewindow import Ui_GameWindow
from game import Game
from boardview import BoardView
class GameWindow(QMainWindow):
  DELAY = 3000
  def __init__(self):
    QMainWindow.__init__(self)
    self.game = Game()
    self.ui = Ui_GameWindow()
    self.ui.setupUi(self)
    layoutHuman = QHBoxLayout(self.ui.humanFrame)
    self.humanBoard = BoardView(self.game.human, True)
    layoutHuman.addWidget(self.humanBoard)
    layoutComputer = QHBoxLayout(self.ui.computerFrame)
    self.computerBoard = BoardView(self.game.computer, True)
    layoutComputer.addWidget(self.computerBoard)
    self.ui.actionNewGame.triggered.connect(self.restart)
    self.ui.actionQuit.triggered.connect(self.close)
    self.ui.startButton.clicked.connect(self.startGame)
    self.humanBoard.message.connect(self.status)
    self.computerBoard.computerMove.connect(self.computerMove)
  def restart(self):
    self.game = Game()
    self.humanBoard.setGame(self.game)
    self.computerBoard.setGame(self.game)
    self.ui.startButton.setEnabled(True)
  def startGame(self):
    self.game.setPlacing(False)
    self.ui.startButton.setEnabled(False)
  def computerMove(self):
    pass
  def status(self, text):
    self.statusBar().showMessage(text, self.DELAY)

