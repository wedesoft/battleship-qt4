require 'test/unit'
require 'game'
class TC_Battleship < Test::Unit::TestCase
  def create_player
    player = Player.new
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
end
