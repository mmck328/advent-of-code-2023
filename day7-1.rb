class Player
  include Comparable
  attr_accessor :hand, :bid

  def initialize(hand, bid)
    @hand = Hand.new(hand)
    @bid = bid
  end

  def <=>(other)
    hand <=> other.hand
  end
end

class Hand
  include Comparable
  attr_accessor :cards, :type

  def initialize(cards)
    @cards = cards.chars.map { |c| Card.new(c) }
    tally = @cards.tally.values.sort.reverse
    @type = tally[0]
    @type += 0.5 if tally[1] == 2
  end

  def <=>(other)
    [type, cards] <=> [other.type, other.cards]
  end
end

class Card
  include Comparable
  attr_accessor :char

  ORDER = %w[A K Q J T 9 8 7 6 5 4 3 2].freeze

  def initialize(char)
    @char = char
  end

  def <=>(other)
    ORDER.index(other.char) <=> ORDER.index(char)
  end

  def eql?(other)
    self == other
  end

  def hash
    char.hash
  end
end

players = []
until (a = gets.chomp).empty?
  h, b = a.split
  players << Player.new(h, b.to_i)
end
# pp players.sort.map{|player| player.hand.cards.map{|c| c.char}.join }
p players.sort.map.with_index(1) { |player, idx| player.bid * idx }.inject(&:+)
