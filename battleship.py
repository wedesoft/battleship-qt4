#!/usr/bin/python
import sys
from PyQt4.QtGui import QApplication
from gamewindow import GameWindow
app = QApplication(sys.argv)
w = GameWindow()
w.show()
sys.exit(app.exec_())

