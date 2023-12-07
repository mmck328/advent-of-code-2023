p gets.split(':')[1].split.map(&:to_i).zip(gets.split(':')[1].split.map(&:to_i)).map{ |time, dist|
  (0..time).count { |push|
    push * (time - push) > dist
  }
}.inject(&:*)
