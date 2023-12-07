class Mapper
  class Entry
    def initialize(dst_start, src_start, len)
      @dst_start = dst_start
      @src_start = src_start
      @len = len
    end

    def in_range?(src)
      (@src_start..@src_start + @len - 1).include?(src)
    end

    def map(src)
      src - @src_start + @dst_start
    end
  end

  def initialize
    @entries = []
  end

  def add(entry)
    @entries << Entry.new(*entry)
  end

  def map(src)
    if (entry = @entries.find { |e| e.in_range?(src) })
      entry.map(src)
    else
      src
    end
  end
end

seeds = gets.split(':')[1].split.map(&:to_i)
gets

until gets.chomp.empty?
  mapper = Mapper.new
  until (entry = gets.chomp.split.map(&:to_i)).empty?
    mapper.add(entry)
  end
  seeds = seeds.map { |seed| mapper.map(seed) }
end

p seeds.min
