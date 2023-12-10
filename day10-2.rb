# ↓ https://qiita.com/kaityo256/items/988bf94bf7b674b8bfdc
Point = Struct.new(:x, :y)
Line = Struct.new(:p1, :p2)

def f(p1, p2, p3)
  (p2.x - p1.x) * (p3.y - p1.y) - (p2.y - p1.y) * (p3.x - p1.x)
end

def intersect?(l1, l2)
  p1, p2, p3, p4 = l1.p1, l1.p2, l2.p1, l2.p2
  t1 = f(p1, p2, p3)
  t2 = f(p1, p2, p4)
  t3 = f(p3, p4, p1)
  t4 = f(p3, p4, p2)
  t1 * t2 < 0.0 and t3 * t4 < 0.0
end
# ↑ https://qiita.com/kaityo256/items/988bf94bf7b674b8bfdc

NORTH = 0
SOUTH = 1
WEST = 2
EAST = 3
def walk(dir, cur)
  case cur
  when '|'
    dir == NORTH ? NORTH : SOUTH
  when '-'
    dir == WEST ? WEST : EAST
  when 'L'
    dir == SOUTH ? EAST : NORTH
  when 'J'
    dir == SOUTH ? WEST : NORTH
  when '7'
    dir == NORTH ? WEST : SOUTH
  when 'F'
    dir == NORTH ? EAST : SOUTH
  else
    ArgumentError.new('invalid pipe')
  end
end

map = []
i = 0
until (row = gets&.chomp&.split(''))&.empty?
  map << row
  if (j = row.find_index('S'))
    start = [i, j]
  end
  i += 1
end

lines = []

if start[0] > 0 && %(|F7).include?(map[start[0] - 1][start[1]])
  dir = NORTH
  current = [start[0] - 1, start[1]]
  lines << Line.new(Point.new(start[0], start[1]), Point.new(start[0] - 1, start[1]))
elsif start[0] < map.size && %(|LJ).include?(map[start[0] + 1][start[1]])
  dir = SOUTH
  current = [start[0] + 1, start[1]]
  lines << Line.new(Point.new(start[0], start[1]), Point.new(start[0] + 1, start[1]))
else
  dir = WEST
  current = [start[0], start[1] - 1]
  lines << Line.new(Point.new(start[0], start[1]), Point.new(start[0], start[1] - 1))
end
# pp start
visited = Set.new
visited << start
until current == start
  visited << current.dup
  dir = walk(dir, map[current[0]][current[1]])
  case dir
  when NORTH
    lines << Line.new(Point.new(current[0], current[1]), Point.new(current[0] - 1, current[1]))
    current[0] -= 1
  when SOUTH
    lines << Line.new(Point.new(current[0], current[1]), Point.new(current[0] + 1, current[1]))
    current[0] += 1
  when WEST
    lines << Line.new(Point.new(current[0], current[1]), Point.new(current[0], current[1] - 1))
    current[1] -= 1
  when EAST
    lines << Line.new(Point.new(current[0], current[1]), Point.new(current[0], current[1] + 1))
    current[1] += 1
  end
end
def judge(pt, lines)
  beam = Line.new(pt, Point.new(-1, pt.y - 0.5))
  lines.count { |line| intersect?(beam, line) }.odd?
end
ans = 0
# pp lines
(0...map.size).each do |i|
  (0...map[0].size).each do |j|
    ans += 1 if !visited.include?([i, j]) && judge(Point.new(i, j), lines)
  end
end
p ans
