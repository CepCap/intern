require_relative 'classes'

war = Warrior.new
thief = Thief.new
immortal = Immortal.new
priest = Priest.new
bard = Bard.new

characters = [war, thief, immortal, priest, bard]

def continue
  puts "Введите любую клавишу, чтобы продолжить"
  gets
end

puts "Почти у каждого персонажа есть HP:"
characters.each { |char| puts "#{char.class}: #{char.hp}" }
continue

puts "\nУ всех персонажей есть урон:"
characters.each { |char| puts "#{char.class}: #{char.attack_damage}" }
continue

puts "\nПочти у всех персонажей есть золото:"
characters.each { |char| puts "#{char.class}: #{char.money}" }
continue

puts "\nКаждый персонаж может атаковать"
puts "#{war.class} атаует #{thief.class}!"
war.attack thief
puts "У #{thief.class} теперь #{thief.hp}HP!"
continue

puts "#{priest.class} может лечить союзников."
puts "#{priest.class} использует лечение на #{thief.class}"
priest.heal thief
puts "У #{thief.class} теперь #{thief.hp}HP!"
continue

puts "#{priest.class} так же может воскрешать союзников"
puts "#{immortal.class} атакует #{bard.class}!"
immortal.attack bard
puts "#{bard.class} мертв!" if bard.dead?
puts "#{priest.class} воскрешает #{bard.class}!"
priest.revive bard
puts "#{bard.class} теперь #{"жив" unless bard.dead?} и у него #{bard.hp}HP!"
continue

puts "#{thief.class} может красть деньги."
puts "#{thief.class} ворует у #{war.class}!."
thief.steal war
puts "У #{thief.class} теперь #{thief.money} золота! А у #{war.class} #{war.money}..."
continue

puts "#{bard.class} может увеличивать силу атаки"
puts "#{bard.class} использует заклинание на #{war.class}!"
bard.buff_attack war
puts "Сила атаки #{war.class} теперь #{war.attack_damage}"
continue

puts "#{bard.class} умеет петь! И иногда на этом зарабатывать..."
input = ''
while input != '0'
  puts bard.sing
  puts "Деньги барда: #{bard.money}"
  puts "Чтобы спеть еще нажмите Enter. Для выхода введите '0'"
  input = gets.chomp
end
