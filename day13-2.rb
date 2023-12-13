def eql_with_fix?(ary1, ary2)
  ary1.flatten.zip(ary2.flatten).count { |x1, x2| x1 != x2 } == 1
end

ans = 0
loop do
  map = []
  until (row = gets&.chomp&.chars)&.empty?
    map << row
  end
  break if map.empty?

  (0...map.size / 2).each do |i|
    ans += (i + 1) * 100 if eql_with_fix?((map[i + 1..].reverse + map[i + 1..]).reverse[...map.size].reverse, map)
  end
  (map.size / 2...map.size - 1).each do |i|
    ans += (i + 1) * 100 if eql_with_fix?((map[..i] + map[..i].reverse)[...map.size], map)
  end
  map = map.transpose
  (0...map.size / 2).each do |i|
    ans += i + 1 if eql_with_fix?((map[i + 1..].reverse + map[i + 1..]).reverse[...map.size].reverse, map)
  end
  (map.size / 2...map.size - 1).each do |i|
    ans += i + 1 if eql_with_fix?((map[..i] + map[..i].reverse)[...map.size], map)
  end
end
p ans
