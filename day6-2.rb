time = gets.split(':')[1].delete(' ').to_i
dist = gets.split(':')[1].delete(' ').to_i
p((0..time).count { |push| push * (time - push) > dist })
