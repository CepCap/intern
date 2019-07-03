puts 'Введите цвет светофора'
color = gets.chomp.downcase
case color
when 'красный'
  puts 'Стоп!'
when 'зеленый'
  puts 'Вперед!'
when 'желтый'
 puts 'Внимание!'
else
  puts 'Неверное значение'
end
