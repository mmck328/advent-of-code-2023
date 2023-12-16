module Direction
  NORTH = 1
  EAST = 2
  SOUTH = 3
  WEST = 4
end

class Beam
  attr_accessor :x, :y, :dir

  def initialize(x, y, dir)
    @x = x
    @y = y
    @dir = dir
  end

  def walk
    case @dir
    when Direction::NORTH
      @y -= 1
    when Direction::EAST
      @x += 1
    when Direction::SOUTH
      @y += 1
    when Direction::WEST
      @x -= 1
    end
    self
  end
end

class Cell
  def initialize(type)
    @type = type
  end

  def next_beams(beam)
    nexts = []
    case @type
    when '.'
      nexts << beam
    when '\\'
      case beam.dir
      when Direction::NORTH
        beam.dir = Direction::WEST
      when Direction::EAST
        beam.dir = Direction::SOUTH
      when Direction::SOUTH
        beam.dir = Direction::EAST
      when Direction::WEST
        beam.dir = Direction::NORTH
      end
      nexts << beam
    when '/'
      case beam.dir
      when Direction::NORTH
        beam.dir = Direction::EAST
      when Direction::EAST
        beam.dir = Direction::NORTH
      when Direction::SOUTH
        beam.dir = Direction::WEST
      when Direction::WEST
        beam.dir = Direction::SOUTH
      end
      nexts << beam
    when '-'
      case beam.dir
      when Direction::NORTH, Direction::SOUTH
        nexts += [Direction::EAST, Direction::WEST].map { |newdir| beam.dup.tap { |b| b.dir = newdir } }
      when Direction::EAST, Direction::WEST
        nexts << beam
      end
    when '|'
      case beam.dir
      when Direction::NORTH, Direction::SOUTH
        nexts << beam
      when Direction::EAST, Direction::WEST
        nexts += [Direction::NORTH, Direction::SOUTH].map { |newdir| beam.dup.tap { |b| b.dir = newdir } }
      end
    end
    nexts.map(&:walk)
  end
end

field = []
until (row = gets&.chomp&.chars)&.empty?
  field << row.map { |char| Cell.new(char) }
end
field = field.transpose

visited = Hash.new { [] }
beams = [Beam.new(0, 0, Direction::EAST)]

until beams.empty?

  beam = beams.shift

  next if !(0...field.size).include?(beam.x) || !(0...field[0].size).include?(beam.y)
  next if visited[[beam.x, beam.y]].include?(beam.dir)

  visited[[beam.x, beam.y]] <<= beam.dir
  cell = field[beam.x][beam.y]
  beams.unshift(*cell.next_beams(beam))
end

p visited.size
