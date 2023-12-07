ans = 0
num = Array.new(1000, 0)
idx = 0
while !(input = gets.chomp).empty?
    num[idx] += 1
    ans += num[idx]
    match = input.split(":")[1].split("|").map(&:split).inject(&:intersection).size
    for i in (idx + 1)..(idx + match)
        num[i] += num[idx]
    end
    idx += 1
end
p ans