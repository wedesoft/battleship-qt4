from PyQt4.QtGui import QMainWindow
from ui_gamewindow import Ui_GameWindow
class GameWindow(QMainWindow):
  def __init__(self):
    QMainWindow.__init__(self)
    self.ui = Ui_GameWindow()
    self.ui.setupUi(self)
    self.ui.actionQuit.triggered.connect(self.close)

