i_row = 1
adj = Array.new(200) {Array.new(200) {Array.new}}
nums = []
symbols = []
effective_num_ids = Set.new
while !(row = gets.chomp).empty?
    cur = 0
    # 数字
    while m = row.match(/\d+/, cur)
        nums << m.to_s.to_i
        num_id = nums.size-1
        from, to = m.offset(0)
        from += 1

        # 上辺/下辺
        for i in from-1..to+1
            adj[i_row-1][i] << num_id
            adj[i_row+1][i] << num_id
        end
        # 両端
        adj[i_row][from-1] << num_id
        adj[i_row][to+1]<< num_id

        cur = to
    end
    
    # シンボル
    row.split("").each_with_index do |c, idx|
        if !c.match?(/\d|\./)
            symbols << [i_row, idx + 1]
        end
    end
    i_row += 1
end

symbols.each { |x, y|
    effective_num_ids.merge(adj[x][y])
}

p effective_num_ids.to_a.map{|id| nums[id]}.inject(&:+)