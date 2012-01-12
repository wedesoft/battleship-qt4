#!/usr/bin/env ruby
# 'The Game Replay: Game Part 1' http://www.youtube.com/watch?v=1z7vgnslBkk
require 'Qt4'
require 'ui_game'
class Game < Qt::MainWindow
  def initialize
    super
    @ui = Ui::Game.new
    @ui.setupUi self
  end
end
app = Qt::Application.new ARGV
window = Game.new
window.show
app.exec
