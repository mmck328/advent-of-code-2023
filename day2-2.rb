def power(infos)
    ["red", "green", "blue"].map{ |col|
        infos.map{|info| (info[col] || 0)}.max
    }.inject(&:*)
end
ans = 0
while game = gets.chomp
    break if game.empty?
    id, body = game.split(":")
    id = id.delete("Game ").to_i
    infos = body.split(";").map {|subset| 
        subset.split(",").map {|color|
            value, key = color.split
            value = value.to_i
            [key, value]
        }.to_h
    }
    ans += power(infos)
end
p ans