from PyQt4.QtGui import QMainWindow
from ui_gamewindow import Ui_GameWindow
class GameWindow(QMainWindow):
  def __init__(self):
    QMainWindow.__init__(self)
    self.ui = Ui_GameWindow()
    self.ui.setupUi(self)
    self.ui.actionQuit.triggered.connect(self.close)
    self.ui.actionNewGame.triggered.connect(self.restart)
    self.ui.startButton.clicked.connect(self.startGame)
  def restart(self):
    self.ui.startButton.setEnabled(True)
  def startGame(self):
    self.ui.startButton.setEnabled(False)

