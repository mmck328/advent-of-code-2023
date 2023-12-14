map = []
until (row = gets&.chomp&.chars)&.empty?
  map << row
end

tilted = map.transpose.map do |row|
  row.chunk { |c| c == '#' }
     .map { |ch| ch[1].sort.reverse }
     .flatten
end.transpose

p tilted.map.with_index { |row, i| row.count('O') * (tilted.size - i) }.sum
