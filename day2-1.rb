def possible(info)
    ((info["red"] || 0) <= 12) && ((info["green"] || 0) <= 13) && ((info["blue"] || 0) <= 14)
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
    ans += id if infos.all?{|info| possible info}
end
p ans