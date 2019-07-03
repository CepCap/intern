def pig(string)
  arr = string.split(' ')
  arr.map do |el|
    el[0], el[-1] = el[-1], el[0]
    el << 'ay'
  end.join(' ')
end

p pig("The quick brown fox")
