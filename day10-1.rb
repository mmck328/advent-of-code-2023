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

if start[0] > 0 && %(|F7).include?(map[start[0] - 1][start[1]])
  dir = NORTH
  current = [start[0] - 1, start[1]]
elsif start[0] < map.size && %(|LJ).include?(map[start[0] + 1][start[1]])
  dir = SOUTH
  current = [start[0] + 1, start[1]]
else
  dir = WEST
  current = [start[0], start[1] - 1]
end
# pp start

step = 1
until current == start
  # puts %(↑↓←→)[dir]
  dir = walk(dir, map[current[0]][current[1]])
  case dir
  when NORTH
    current[0] -= 1
  when SOUTH
    current[0] += 1
  when WEST
    current[1] -= 1
  when EAST
    current[1] += 1
  end
  step += 1
  # sleep 1
end
p (step / 2.0).ceil
