def reverse1(string)
  arr = string.chars
  reversed = []
  arr.length.downto(0) do |i|
    reversed << arr[i]
  end
  reversed.join('')
end

def reverse2(string)
  arr = string.chars
  arr.map.with_index do |el, index|
    arr[arr.length - index - 1]
  end.join('')
end

p reverse1('lets try this')
p reverse2('lets try this')
