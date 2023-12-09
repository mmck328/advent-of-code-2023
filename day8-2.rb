instruction = gets.chomp.chars
gets
nodes = {}
current = []
until (str = gets.chomp).empty?
  nodes[str[0..2]] = str[7..9], str[12..14]
  current << str[0..2] if str[2] == 'A'
end

(0..).each do |i|
  print "#{i}\r"
  if current.all? { |n| n[2] == 'Z' }
    puts
    exit
  end
  idx = instruction[i % instruction.size] == 'L' ? 0 : 1
  current.map! { |n| nodes[n][idx] }
end
