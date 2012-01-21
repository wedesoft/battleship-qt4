#!/usr/bin/python
import sys
from PyQt4 import QtGui
from gamewindow import GameWindow
app = QtGui.QApplication(sys.argv)
w = GameWindow()
w.show()
sys.exit(app.exec_())

