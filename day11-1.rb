map = []
until (row = gets&.chomp&.chars)&.empty?
  map << row
  map << row if row.all?('.')
end
map = map.transpose
map = map.each_with_object([]) do |row, map|
  map << row
  map << row if row.all?('.')
end
map = map.transpose

galaxies = []
Point = Struct.new(:x, :y)
(0...map.size).each do |i|
  (0..map[0].size).each do |j|
    galaxies << Point.new(i, j) if map[i][j] == '#'
  end
end
p galaxies.combination(2).map { |p1, p2| (p1.x - p2.x).abs + (p1.y - p2.y).abs }.sum
