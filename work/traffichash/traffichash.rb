traffic = { красный: 'Stop.', желтый: 'Attention.', зеленый: 'Go!' }

loop do
  puts 'Введите цвет:'
  input = gets.chomp.downcase.to_sym
  puts traffic[input]
end
