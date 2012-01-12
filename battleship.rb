#!/usr/bin/env ruby
# 'The Game Replay: Game Part 1' http://www.youtube.com/watch?v=1z7vgnslBkk
# resource file?
# operating system dependent style
require 'Qt4'
require 'game'
require 'ui_gamewindow'
require 'ui_content'
class BoardView < Qt::Widget
  signals 'message(QString)'
  PANEL = 'panel.svg'
  SHIPS = ['carrier.svg', 'battleship.svg', 'destroyer.svg',
           'submarine.svg', 'patrol boat.svg']
  def initialize(player, visible, parent = nil)
    super parent
    @player = player
    @visible = visible
    @panel = Qt::SvgRenderer.new PANEL
    @ship = SHIPS.collect { |filename| Qt::SvgRenderer.new filename }
    @moving, @x0, @y0, @dx, @dy = nil, 0, 0, 0, 0
  end
  def board=(value)
    @player = value
    update
  end
  def mousePressEvent(e)
    w, h = width / Player::N, height / Player::N
    bx, by = e.x / w, e.y / h
    if @player.placing?
      ship = @player.ship_at(bx, by)
      if ship
        if e.button == Qt::LeftButton
          @moving = ship
          @x0, @y0 = e.x, e.y
        else
          x, y, vertical = *@player.ship(ship)
          dx, dy = bx - x, by - y
          if @player.place ship, x + dx - dy, y + dy - dx, !vertical
            emit message("#{Player::TITLE[ship]} rotated")
          else
            emit message('Invalid placement')
          end
          update
        end
      end
    end
  end
  def mouseMoveEvent(e)
    if @moving
      @dx, @dy = e.x - @x0, e.y - @y0
      update
    end
  end
  def mouseReleaseEvent(e)
    if @moving
      w, h = width / Player::N, height / Player::N
      x, y, vertical = *@player.ship(@moving)
      x += (@dx + w / 2) / w
      y += (@dy + h / 2) / h
      if @player.place @moving, x, y, vertical
        emit message("#{Player::TITLE[@moving]} placed")
      else
        emit message('Invalid placement')
      end
      @moving, @x0, @y0, @dx, @dy = nil, 0, 0, 0, 0
      update
    end
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
        unless i == @moving
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
  attr_reader :game
  attr_reader :human_board
  attr_reader :computer_board
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
  def game=(value)
    @game = value
    @human_board.board = @game.human
    @computer_board.board = @game.computer
  end
end
class GameWindow < Qt::MainWindow
  DELAY = 3000
  slots 'restart()'
  slots 'placement_done()'
  slots 'status(QString)'
  def initialize
    super
    @game = Game.new
    @ui = Ui::GameWindow.new
    @ui.setupUi self
    @content = Content.new @game, self
    setCentralWidget @content
    connect @ui.actionNewGame, SIGNAL('activated()'), self, SLOT('restart()')
    connect @ui.actionFinishPlacement, SIGNAL('activated()'), self, SLOT('placement_done()')
    connect @ui.actionQuit, SIGNAL('activated()'), self, SLOT('close()')
    connect @content.human_board, SIGNAL('message(QString)'), self, SLOT('status(QString)')
  end
  def restart
    @game = Game.new
    @content.game = @game
    @ui.actionFinishPlacement.enabled = true
  end
  def placement_done
    @content.game.placing = false
    @ui.actionFinishPlacement.enabled = false
  end
  def status(text)
    statusBar.showMessage text, DELAY
  end
end
app = Qt::Application.new ARGV
window = GameWindow.new
window.show
app.exec

