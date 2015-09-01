class Player

  attr_reader :color

  def initialize(color)
    @color = color
  end

  def get_move(display)
    start_pos = get_pos(display)
    end_pos = get_pos(display)
    [start_pos, end_pos]
  end

  def get_pos(display)
    pos = nil
    until pos
      display.render
      pos = display.get_input
    end
    pos
  end



end
