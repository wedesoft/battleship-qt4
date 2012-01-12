#!/usr/bin/env ruby
# 'The Game Replay: Game Part 1' http://www.youtube.com/watch?v=1z7vgnslBkk
# resource file?
# operating system dependent style
require 'Qt4'
require 'ui_gamewindow'
require 'ui_content'
class Player
  N = 10
  LENGTH = [2, 3, 3, 4, 5]
  def initialize
    @ship = [[0, 0, false], [0, 1, false], [0, 2, false], [0, 3, false], [0, 4, false]]
    @board = [[0] * N] * N
  end
  def ship(i)
    @ship[i]
  end
  def ship_at(bx, by)
    @ship.zip(LENGTH).index do |ship, length|
      x, y, vertical = *ship
      unless vertical
        bx >= x and bx < x + length and by == y
      else
        bx == x and by >= y and by < y + length
      end
    end
  end
end
class Game
  attr_reader :human
  attr_reader :computer
  def initialize
    @human = Player.new
    @computer = Player.new
  end
end
class BoardView < Qt::Widget
  PANEL = 'panel.svg'
  SHIPS = ['carrier.svg', 'battleship.svg', 'destroyer.svg',
           'submarine.svg', 'patrol boat.svg']
  def initialize(player, visible, parent = nil)
    super parent
    @player = player
    @visible = visible
    @panel = Qt::SvgRenderer.new PANEL
    @ship = SHIPS.collect { |filename| Qt::SvgRenderer.new filename }
    @placing, @x0, @y0, @dx, @dy = nil, 0, 0, 0, 0
  end
  def mousePressEvent(e)
    w, h = width / Player::N, height / Player::N
    bx, by = e.x / w, e.y / h
    @placing = @player.ship_at(bx, by)
    if @placing
      @x0, @y0 = e.x, e.y
    end
  end
  def mouseMoveEvent(e)
    @dx, @dy = e.x - @x0, e.y - @y0
    update
  end
  def mouseReleaseEvent(e)
    @placing, @x0, @y0, @dx, @dy = nil, 0, 0, 0, 0
    update
  end
  def paintEvent(e)
    w, h = width / Player::N, height / Player::N
    painter = Qt::Painter.new self
    for j in 0 ... Player::N
      for i in 0 ... Player::N
        @panel.render painter, Qt::RectF.new(i * w, j * h, w, h)
      end
    end
    if @visible
      @ship.each_with_index do |ship,i|
        x, y, vertical = *@player.ship(i)
        unless i == @placing
          dx, dy = 0, 0
        else
          dx, dy = @dx, @dy
        end
        unless vertical
          painter.setTransform Qt::Transform.new
          ship.render painter,
                      Qt::RectF.new(x * w + dx, y * h + dy, w * Player::LENGTH[i], h)
        else
          painter.setTransform Qt::Transform.new 0, 1, 1, 0, 0, 0
          ship.render painter,
                      Qt::RectF.new(y * h + dy, x * w + dx, h * Player::LENGTH[i], h)
        end
      end
    end
  end
end
class Content < Qt::Widget
  def initialize(game, parent = nil)
    super parent
    @game = game
    @ui = Ui::Content.new
    @ui.setupUi self
    layout_human = Qt::HBoxLayout.new @ui.humanFrame
    @human_board = BoardView.new @game.human, true
    layout_human.addWidget @human_board
    layout_computer = Qt::HBoxLayout.new @ui.computerFrame
    @computer_board = BoardView.new @game.computer, false
    layout_computer.addWidget @computer_board
  end
end
class GameWindow < Qt::MainWindow
  def initialize
    super
    @game = Game.new
    @ui = Ui::GameWindow.new
    @ui.setupUi self
    @content = Content.new @game, self
    setCentralWidget @content
  end
end
app = Qt::Application.new ARGV
window = GameWindow.new
window.show
app.exec

