map = []
gap_x = []
gap_y = []
idx = 0
until (row = gets&.chomp&.chars)&.empty?
  map << row
  gap_x << idx if row.all?('.')
  idx += 1
end
map = map.transpose
map = map.each_with_index do |row, idx|
  gap_y << idx if row.all?('.')
end
map = map.transpose

galaxies = []
Point = Struct.new(:x, :y)
(0...map.size).each do |i|
  (0..map[0].size).each do |j|
    galaxies << Point.new(i, j) if map[i][j] == '#'
  end
end
multiplier = 1_000_000
p galaxies.combination(2).map { |p1, p2|
  (p1.x - p2.x).abs + (p1.y - p2.y).abs + gap_x.count{|gx| ([p1.x, p2.x].min..[p1.x, p2.x].max).include? gx} * (multiplier - 1) + gap_y.count{|gy| ([p1.y, p2.y].min..[p1.y, p2.y].max).include? gy} * (multiplier - 1)
}.sum
