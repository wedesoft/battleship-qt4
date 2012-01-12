class BoardView < Qt::Widget
  signals 'message(QString)'
  signals 'computer_move()'
  PANEL = 'panel.svg'
  HIT = 'hit.svg'
  MISS = 'miss.svg'
  SHIPS = ['carrier.svg', 'battleship.svg', 'destroyer.svg',
           'submarine.svg', 'patrol boat.svg']
  def initialize(player, visible, parent = nil)
    super parent
    @player = player
    @visible = visible
    @panel = Qt::SvgRenderer.new PANEL
    @hit = Qt::SvgRenderer.new HIT
    @miss = Qt::SvgRenderer.new MISS
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
    if @visible and @player.placing?
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
    else
      if not @visible and @player.board(bx, by) == :unknown and not @player.game_over?
        @player.target bx, by
        update
        emit computer_move
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
    for j in 0 ... Player::N
      for i in 0 ... Player::N
        state = @player.board i, j
        if state == :hit
          @hit.render painter, Qt::RectF.new(i * w, j * h, w, h)
        elsif state == :miss
          @miss.render painter, Qt::RectF.new(i * w, j * h, w, h)
        end
      end
    end
  end
end

