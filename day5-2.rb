class Mapper
  class Entry
    def initialize(dst_start, src_start, len)
      @dst_start = dst_start
      @src_start = src_start
      @len = len
      @src_end = @src_start + @len - 1
      @diff = @dst_start - @src_start
    end

    def map_single(src)
      # puts "map_single(#{src}) #{@src_start}..#{@src_end} #{@diff}"
      if src.max < @src_start
        [[], [src]]
      elsif src.max <= @src_end
        if src.min < @src_start
          [[@src_start + @diff..src.max + @diff], [src.min..@src_start - 1]]
        else
          [[src.min + @diff..src.max + @diff], []]
        end
      elsif src.min < @src_start
        [[@src_start + @diff..@src_end + @diff], [src.min..@src_start - 1, @src_end + 1..src.max]]
      elsif src.min <= @src_end
        [[src.min + @diff..@src_end + @diff], [@src_end + 1..src.max]]
      else
        [[], [src]]
      end
    end

    def map(src_list)
      mapped = []
      remaining = []
      src_list.each do |src|
        m, r = map_single(src)
        # pp [m, r]
        mapped << m
        remaining << r
      end
      [mapped.flatten, remaining.flatten]
    end
  end

  def initialize
    @entries = []
  end

  def add(entry)
    @entries << Entry.new(*entry)
  end

  def map(src)
    remaining = src
    mapped = []
    @entries.each do |entry|
      m, remaining = entry.map(remaining)
      mapped << m
    end
    (mapped + remaining).flatten
  end
end

seed_ranges = gets.split(':')[1].split.map(&:to_i).each_slice(2).map { |a, b| a..a + b - 1 }
gets
# pp seed_ranges

until gets.chomp.empty?
  mapper = Mapper.new
  until (entry = gets.chomp.split.map(&:to_i)).empty?
    mapper.add(entry)
  end
  seed_ranges = mapper.map(seed_ranges).flatten
  pp seed_ranges
end
p seed_ranges.map(&:min).min
