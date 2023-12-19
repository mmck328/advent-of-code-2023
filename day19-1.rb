Rule = Struct.new(:condition, :destination)
workflows = {}
until (line = gets&.chomp).empty?
  key, body = line.split('{')
  rules = body.scan(/(?:[xmas][<>]\d+:)?[a-zA-Z]+/).map do |rule|
    if rule.include?(':')
      condition, destination = rule.split(':')
    else
      condition = 'true'
      destination = rule
    end
    Rule.new(->(x, m, a, s) { eval condition }, destination)
  end
  workflows[key] = rules
end

ans = 0
until (line = gets&.chomp).empty?
  x, m, a, s = line.match(/\{x=(\d+),m=(\d+),a=(\d+),s=(\d+)\}/)[1..4].map(&:to_i)
  destination = 'in'
  until %w[A R].include?(destination)
    destination = workflows[destination].find { |rule| rule.condition.call(x, m, a, s) }.destination
  end
  ans += x + m + a + s if destination == 'A'
end
p ans
