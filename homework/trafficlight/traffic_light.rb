puts 'Введите цвет светофора'
color = gets.chomp.downcase
if color == 'красный'
  puts 'Стоп!'
elsif color == 'зеленый'
  puts 'Вперед!'
elsif color == 'желтый'
 puts 'Внимание!'
else
  puts 'Неверное значение'
end
