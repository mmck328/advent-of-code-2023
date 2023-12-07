ans = 0
h = {'one'=> 1, 'two'=>2, 'three'=>3, 'four'=>4, 'five'=>5, 'six'=> 6, 'seven'=>7, 'eight'=>8, 'nine'=>9}
while s = gets.chomp
    nums = s.scan(/(?=(one|two|three|four|five|six|seven|eight|nine|\d))/).flatten
        .map{|ss| h[ss] ? h[ss] : ss}
        .map(&:to_i)
    break if nums.empty?
    ans += nums[0] * 10  + nums[-1]
end
p ans