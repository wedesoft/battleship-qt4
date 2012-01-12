require 'ui_content'
require 'boardview'
class Content < Qt::Widget
  slots 'computer_move()'
  signals 'message(QString)'
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
    connect @computer_board, SIGNAL('computer_move()'), self, SLOT('computer_move()')
  end
  def game=(value)
    @game = value
    @human_board.board = @game.human
    @computer_board.board = @game.computer
  end
  def computer_move
    if @game.computer.defeated?
      emit message('HUMAN WINS!!!')
    else
      @game.computer_move
      @human_board.update
      if @game.human.defeated?
        emit message('COMPUTER WINS!!!')
      end
    end
  end
end

