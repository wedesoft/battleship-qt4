require 'test/unit'
require 'game'
class TC_Battleship < Test::Unit::TestCase
  def create_player
    player = Player.new Game.new
    player.place 0, 0, 0, false
    player.place 1, 0, 1, false
    player.place 2, 0, 2, false
    player.place 3, 0, 3, false
    player.place 4, 0, 4, false
    player
  end
  def test_placement
    player = create_player
    assert player.place(0, 4, 1, false)
    assert !player.place(0, 3, 1, false)
    assert player.place(0, 4, 0, true)
    assert !player.place(0, 0, 0, true)
  end
  def test_boundaries
    player = create_player
    assert !player.place(0, -1, 0, false)
    assert player.place(0, 0, 0, false)
    assert player.place(0, 5, 0, false)
    assert !player.place(0, 6, 0, false)
    assert !player.place(0, 9, -1, true)
    assert player.place(0, 9, 0, true)
    assert player.place(0, 9, 5, true)
    assert !player.place(0, 9, 6, true)
  end
  def test_placing_off
    game = Game.new
    assert game.placing?
    game.placing = false
    assert !game.placing?
  end
  def test_target
    player = create_player
    assert_equal :unknown, player.board(0, 0)
    player.target 7, 7
    assert_equal :miss, player.board(7, 7)
    player.target 0, 0
    assert_equal :hit, player.board(0, 0)
  end
end
