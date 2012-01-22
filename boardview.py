from PyQt4.QtCore import pyqtSignal, QRectF, QString
from PyQt4.QtGui import QWidget, QPainter
from PyQt4.QtSvg import QSvgRenderer
from player import Player
class BoardView(QWidget):
  message = pyqtSignal(QString)
  computerMove = pyqtSignal()
  PANEL = ":/images/panel.svg"
  HIT = ":/images/hit.svg"
  MISS = ":/images/miss.svg"
  def __init__(self, player, visible, parent = None):
    QWidget.__init__(self, parent)
    self.player = player
    self.visible = visible
    self.panel = QSvgRenderer(self.PANEL, self)
    self.hit = QSvgRenderer(self.HIT, self)
    self.miss = QSvgRenderer(self.MISS, self)
  def setBoard(value):
    self.player = value
    self.update()
  def paintEvent(self, e):
    w, h = self.width() / Player.N, self.height() / Player.N
    painter = QPainter(self)
    for j in range(0, Player.N):
      for i in range(0, Player.N):
        self.panel.render(painter, QRectF(i * w, j * h, w, h))

