# 2) Написать конвертер температуры из цельсия в кельвины/и наоборот

puts "1. Из цельсия в кельвины \n2. Из кельвина в цельсия"
choice = gets.to_i
print 'Введите значение: '
value = gets.to_i

if choice == 1
  value += 273.15
else
  value -= 273.15
end

puts "Результат: #{value}#{choice == 1 ? 'K' : 'c'}"
