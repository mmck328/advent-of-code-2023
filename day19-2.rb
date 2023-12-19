Rule = Struct.new(:condition, :negative, :destination)

class Condition
  attr_accessor :x, :m, :a, :s

  def initialize(x: 1..4000, m: 1..4000, a: 1..4000, s: 1..4000)
    @x = x
    @m = m
    @a = a
    @s = s
  end

  def +(other)
    x = [@x.min, other.x.min].max..[@x.max, other.x.max].min
    m = [@m.min, other.m.min].max..[@m.max, other.m.max].min
    a = [@a.min, other.a.min].max..[@a.max, other.a.max].min
    s = [@s.min, other.s.min].max..[@s.max, other.s.max].min
    [x, m, a, s].any? { |r| r.size == 0 } ? nil : Condition.new(x:, m:, a:, s:)
  end

  def size
    @x.size * @m.size * @a.size * @s.size
  end
end

workflows = {}
until (line = gets&.chomp).empty?
  key, body = line.split('{')
  rules = body.scan(/(?:[xmas][<>]\d+:)?[a-zA-Z]+/).map do |rule|
    condition = Condition.new
    negative = Condition.new
    if rule.include?(':')
      condition_str, destination = rule.split(':')
      var, ope, val = condition_str.match(/([xmas])([<>])(\d+)/).captures
      val = val.to_i
      condition.send("#{var}=".to_sym, ope == '<' ? (1..val - 1) : (val + 1..4000))
      negative.send("#{var}=".to_sym, ope == '<' ? (val..4000) : (1..val))
    else
      negative = nil
      destination = rule
    end
    Rule.new(condition, negative, destination)
  end
  workflows[key] = rules
end

queue = [['in', Condition.new]]
accepted_conditions = []
until queue.empty?
  key, current_condition = queue.shift
  next if current_condition.nil?
  next if key == 'R'

  if key == 'A'
    accepted_conditions << current_condition
    next
  end

  workflows[key].each do |rule|
    queue << [rule.destination, current_condition + rule.condition]
    current_condition += rule.negative if rule.negative
  end
end

until gets&.chomp&.empty?
end

p accepted_conditions.sum(&:size)
