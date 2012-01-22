from PyQt4.QtCore import pyqtSignal, QString
from PyQt4.QtGui import QWidget
class BoardView(QWidget):
  message = pyqtSignal(QString)
  computerMove = pyqtSignal()
  def __init__(self, player, visible, parent = None):
    QWidget.__init__(self, parent)

