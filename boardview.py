from PyQt4.QtCore import pyqtSignal, QRectF, QString
from PyQt4.QtGui import QWidget, QPainter, QTransform
from PyQt4.QtSvg import QSvgRenderer
from player import Player
class BoardView(QWidget):
  message = pyqtSignal(QString)
  computerMove = pyqtSignal()
  PANEL = ":/images/panel.svg"
  HIT = ":/images/hit.svg"
  MISS = ":/images/miss.svg"
  SHIPS = [':/images/carrier.svg', ':/images/battleship.svg', ':/images/destroyer.svg',
           ':/images/submarine.svg', ':/images/patrol boat.svg']
  def __init__(self, player, visible, parent = None):
    super(BoardView, self).__init__(parent)
    self.player = player
    self.visible = visible
    self.panel = QSvgRenderer(self.PANEL, self)
    self.hit = QSvgRenderer(self.HIT, self)
    self.miss = QSvgRenderer(self.MISS, self)
    self.ship = [QSvgRenderer(filename, self) for filename in self.SHIPS]
    self.moving, self.x0, self.y0, self.dx, self.dy = None, 0, 0, 0, 0
  def setBoard(self, value):
    self.player = value
    self.update()
  def paintEvent(self, e):
    w, h = self.width() / Player.N, self.height() / Player.N
    painter = QPainter(self)
    for j in range(0, Player.N):
      for i in range(0, Player.N):
        self.panel.render(painter, QRectF(i * w, j * h, w, h))
    if self.visible:
      for i in range(0, self.ship.__len__()):
        ship = self.ship[i]
        x, y, vertical = self.player.getShip(i)
        if not i == self.moving:
          dx, dy = 0, 0
        else:
          dx, dy = self.dx, self.dy
        if not vertical:
          ship.render(painter, QRectF(x * w + dx, y * h + dy, w * Player.LENGTH[i], h))
        else:
          painter.setTransform(QTransform(0, 1, 1, 0, 0, 0))
          ship.render(painter, QRectF(y * h + dy, x * w + dx, h * Player.LENGTH[i], w))
          painter.resetTransform()

