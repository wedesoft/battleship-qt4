#!/usr/bin/env ruby
# 'The Game Replay: Game Part 1' http://www.youtube.com/watch?v=1z7vgnslBkk
# resource file?
# operating system dependent style
require 'Qt4'
require 'gamewindow'
app = Qt::Application.new ARGV
window = GameWindow.new
window.show
app.exec

