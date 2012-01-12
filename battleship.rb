#!/usr/bin/env ruby
# 'The Game Replay: Game Part 1' http://www.youtube.com/watch?v=1z7vgnslBkk
# resource file?
# operating system dependent style
require 'Qt4'
require 'ui_gamewindow'
require 'ui_content'
class Board < Qt::Widget
  SIZE = 10
  PANEL = 'panel.svg'
  SHIPS = ['carrier.svg', 'battleship.svg', 'destroyer.svg',
           'submarine.svg', 'patrol boat.svg']
  LENGTH = [2, 3, 3, 4, 5]
  def initialize(parent = nil)
    super parent
    @panel = Qt::SvgRenderer.new PANEL
    @ship = SHIPS.collect { |filename| Qt::SvgRenderer.new filename }
  end
  def paintEvent(e)
    p width
    w, h = width / SIZE, height / SIZE
    painter = Qt::Painter.new self
    for j in 0 ... SIZE
      for i in 0 ... SIZE
        @panel.render painter, Qt::RectF.new(i * w, j * h, w, h)
      end
    end
    @ship.each_with_index do |ship,i|
      ship.render painter, Qt::RectF.new(0, i * h, w * LENGTH[i], h)
    end
  end
end
class Content < Qt::Widget
  def initialize(parent = nil)
    super parent
    @ui = Ui::Content.new
    @ui.setupUi self
    layout = Qt::HBoxLayout.new @ui.playerGroup
    @player = Board.new
    layout.addWidget @player
  end
end
class GameWindow < Qt::MainWindow
  def initialize
    super
    @ui = Ui::GameWindow.new
    @ui.setupUi self
    @content = Content.new self
    setCentralWidget @content
  end
end
app = Qt::Application.new ARGV
window = GameWindow.new
window.show
app.exec
