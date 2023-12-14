def load(map)
  map.map.with_index { |row, i| row.count('O') * (map.size - i) }.sum
end

map = []
until (row = gets&.chomp&.chars)&.empty?
  map << row
end
history = [map]

loop_l, loop_r = loop do
  rotated = history[-1]
  4.times do
    rotated = rotated.transpose.map do |row|
      row.reverse
         .chunk { |c| c == '#' }
         .map { |ch| ch[1].sort }
         .flatten
    end
  end

  duplicate = history.index(rotated)
  break [duplicate, history.size] if duplicate

  history << rotated
end
p load(history[loop_l...loop_r][(1_000_000_000 - loop_l) % (loop_r - loop_l)])
