ans = 0
until (values = gets&.split&.map(&:to_i)).empty?
  table = [values]
  table << table[-1].each_cons(2).map { |v1, v2| v2 - v1 } until table[-1].all?(0)
  table.reverse.each_cons(2) do |below, above|
    above.unshift(above[0] - below[0])
  end
  ans += table[0][0]
end
p ans
