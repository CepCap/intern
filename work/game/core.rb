require_relative 'battle'

loop do
  bard, warrior, thief, priest = Bard.new, Warrior.new, Thief.new, Priest.new
  bard.name = 'Гулвир'
  warrior.name = 'Тебнар'
  thief.name = 'Грукралл'
  priest.name = 'Луджор'
  characters = [bard, warrior, thief, priest]
  party1 = [characters.sample.clone, characters.sample.clone]
  party2 = [characters.sample.clone, characters.sample.clone]

  battle = Battle.new(party1, party2)

  loop do
    break if battle.round == :end
    puts "Нажмите enter для продолжения"
    gets
  end

  puts "Сыграем еще? Y/N"
  input = gets.chomp.downcase
  exit if input == 'n'
end
