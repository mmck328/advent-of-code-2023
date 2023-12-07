ans = 0
while s = gets.chomp
    nums = s.chars.filter{|c| c.match?('\\d')}.map(&:to_i)
    break if nums.empty?
    ans += nums[0] * 10  + nums[-1]
end
p ans