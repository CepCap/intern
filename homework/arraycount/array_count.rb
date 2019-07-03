# 5) Написать реализацию, чтобы из исходного Array получить на выходе
# Hash типа { elem => element count }, где ключ - это элемент массива, а значение - частота его встречаемости в массиве?
# Исходный массив
# [:foo, nil, :foo, "foo", 5, 'bar', :foo, 'banana', 'milk', 12, :foo, 'bar', 34, 5, 'banana', 'milk', nil, 12, 45, 'milk']
initial_array = [:foo, nil, :foo, "foo", 5, 'bar', :foo, 'banana', 'milk', 12, :foo, 'bar', 34, 5, 'banana', 'milk', nil, 12, 45, 'milk']
result_hash = {}

initial_array.uniq.each { |el| result_hash[el] = initial_array.count(el)  }

p result_hash
