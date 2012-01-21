require 'ui_gamewindow'
require 'boardview'
require 'game'
class GameWindow < Qt::MainWindow
  DELAY = 3000
  slots 'restart()'
  slots 'status(QString)'
  slots 'computer_move()'
  slots 'start_game()'
  def initialize
    super
    @ui = Ui::GameWindow.new
    @ui.setupUi self
    @game = Game.new
    layout_human = Qt::HBoxLayout.new @ui.humanFrame
    @human_board = BoardView.new @game.human, true
    layout_human.addWidget @human_board
    layout_computer = Qt::HBoxLayout.new @ui.computerFrame
    @computer_board = BoardView.new @game.computer, false
    layout_computer.addWidget @computer_board
    connect @ui.actionNewGame, SIGNAL('triggered()'), self, SLOT('restart()')
    connect @ui.actionQuit, SIGNAL('triggered()'), self, SLOT('close()')
    connect @ui.startButton, SIGNAL('clicked()'), self, SLOT('start_game()')
    connect @human_board, SIGNAL('message(QString)'), self, SLOT('status(QString)')
    connect @computer_board, SIGNAL('computer_move()'), self, SLOT('computer_move()')
  end
  def restart
    @game = Game.new
    @human_board.board = @game.human
    @computer_board.board = @game.computer
    @ui.startButton.enabled = true
  end
  def start_game
    @game.placing = false
    @ui.startButton.enabled = false
  end
  def computer_move
    if @game.computer.defeated?
      status 'HUMAN WINS!!!'
    else
      @game.computer_move
      @human_board.update
      if @game.human.defeated?
        status 'COMPUTER WINS!!!'
      end
    end
  end
  def status(text)
    statusBar.showMessage text, DELAY
  end
end

