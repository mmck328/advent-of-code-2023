ans = 0
until (values = gets&.split&.map(&:to_i)).empty?
  table = [values]
  table << table[-1].each_cons(2).map { |v1, v2| v2 - v1 } until table[-1].all?(0)
  table.reverse.each_cons(2) do |below, above|
    above << above[-1] + below[-1]
  end
  ans += table[0][-1]
end
p ans
