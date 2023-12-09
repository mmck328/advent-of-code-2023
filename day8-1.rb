instruction = gets.chomp.chars
gets
nodes = {}
until (str = gets.chomp).empty?
  nodes[str[0..2]] = str[7..9], str[12..14]
end
current = 'AAA'
(0..).each do |i|
  if current == 'ZZZ'
    p i
    exit
  end
  current = instruction[i % instruction.size] == 'L' ? nodes[current][0] : nodes[current][1]
end
