require 'ui_gamewindow'
require 'game'
require 'content'
class GameWindow < Qt::MainWindow
  DELAY = 3000
  slots 'restart()'
  slots 'status(QString)'
  def initialize
    super
    @game = Game.new
    @ui = Ui::GameWindow.new
    @ui.setupUi self
    @content = Content.new @game, self
    setCentralWidget @content
    connect @ui.actionNewGame, SIGNAL('activated()'), self, SLOT('restart()')
    connect @ui.actionQuit, SIGNAL('activated()'), self, SLOT('close()')
    connect @content, SIGNAL('message(QString)'), self, SLOT('status(QString)')
    connect @content.human_board, SIGNAL('message(QString)'), self, SLOT('status(QString)')
  end
  def restart
    @game = Game.new
    @content.game = @game
  end
  def status(text)
    statusBar.showMessage text, DELAY
  end
end

