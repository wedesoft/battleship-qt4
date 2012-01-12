class Player
  N = 10
  LENGTH = [5, 4, 3, 3, 2]
  TITLE = ['Carrier', 'Battleship', 'Destroyer', 'Submarine', 'Patrol boat']
  def initialize(game)
    @game = game
    @ship = [[0, 0, false], [0, 1, false], [0, 2, false], [0, 3, false], [0, 4, false]]
    @board = (0 ... N).collect { (0 ... N).collect { false } }
    @placing = false
  end
  def placing?
    @game.placing?
  end
  def game_over?
    @game.over?
  end
  def ship(i)
    @ship[i]
  end
  def target(x, y)
    @game.placing = false
    @board[y][x] = true
  end
  def hits
    retval = 0
    for y in 0 ... N
      for x in 0 ... N
        retval += 1 if board(x, y) == :hit
      end
    end
    retval
  end
  def defeated?
    hits == LENGTH.inject { |a, b| a + b }
  end
  def board(x, y)
    if @board[y][x]
      if ship_at(x, y)
        :hit
      else
        :miss
      end
    else
      :unknown
    end
  end
  def place(i, x, y, vertical)
    previous = @ship[i]
    @ship[i] = [x, y, vertical]
    ok = valid?
    @ship[i] = previous unless ok
    ok
  end
  def valid?
    retval = true
    @ship.each_with_index do |ship1, i1|
      x1, y1, vertical1 = *ship1
      w1 = vertical1 ? 1 : LENGTH[i1]
      h1 = vertical1 ? LENGTH[i1] : 1
      retval = false unless x1 >= 0 and y1 >= 0 and x1 + w1 <= N and y1 + h1 <= N
      @ship.each_with_index do |ship2, i2|
        if i1 != i2
          x2, y2, vertical2 = *ship2
          w2 = vertical2 ? 1 : LENGTH[i2]
          h2 = vertical2 ? LENGTH[i2] : 1
          unless x1 + w1 <= x2 or x1 >= x2 + w2 or y1 + h1 <= y2 or y1 >= y2 + h2
            retval = false
          end
        end
      end
    end
    retval
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
    move = false
    while not move
      x, y = rand(Player::N), rand(Player::N)
      if @human.board(x, y) == :unknown
        @human.target x, y
        move = true
      end
    end
  end
  def over?
    @human.defeated? or @computer.defeated?
  end
end

