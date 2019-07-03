def frame(array)
  row = '*' * (array.last.length + 2)
  array.map! { |el| '*' + el + ' ' * (array.last.length - el.length) + '*' }
  array.unshift(row)
  array << row
  array.join("\n")
end

puts frame(["Hello", "World", "in", "a", "frame"])
