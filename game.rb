require 'player'
class Game
  attr_reader :human
  attr_reader :computer
  def initialize
    @human = Player.new self
    @computer = Player.new self
    @placing = true
  end
  def placing=(value)
    @placing = value
  end
  def placing?
    @placing
  end
  def computer_move
    unknown = []
    prefer = []
    for y in 0 ... Player::N
      for x in 0 ... Player::N
        if @human.board(x, y) == :unknown
          unknown.push [x, y]
          prefer.push [x, y] if @human.neighbour_hit(x, y)
        end
      end
    end
    unless prefer.empty?
      @human.target *prefer[rand(prefer.size)]
    else
      @human.target *unknown[rand(unknown.size)]
    end
  end
  def over?
    @human.defeated? or @computer.defeated?
  end
end

