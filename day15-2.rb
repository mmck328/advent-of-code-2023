def HASH(str)
  str.codepoints.inject(0) { |current, code| (current + code) * 17 % 256 }
end

seq = gets.chomp.split(',')
boxes = Array.new(256) { [] }
Lens = Struct.new(:label, :length)
seq.each do |step|
  if step.include?('-')
    label = step.split('-')[0]
    boxes[HASH(label)].delete_if { |lens| lens.label == label }
  else
    label, length = step.split('=')
    length = length.to_i
    box = boxes[HASH(label)]
    box[box.index { |lens| lens.label == label } || box.size] = Lens.new(label, length)
  end
end
p(boxes.each.with_index(1).sum { |box, i| box.each.with_index(1).sum { |lens, j| i * j * lens.length } })
