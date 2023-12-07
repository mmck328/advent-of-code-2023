ans = 0
while !(input = gets.chomp).empty?
    ans += 2 ** (input.split(":")[1].split("|").map(&:split).inject(&:intersection).size) / 2
end
p ans