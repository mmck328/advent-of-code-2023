def calc(str)
  str.codepoints.inject(0) { |current, code| (current + code) * 17 % 256 }
end

seq = gets.chomp.split(',')
p seq.map { |str| calc(str) }.sum