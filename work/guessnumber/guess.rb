class Game
  def initialize
    @high = 100
    @mid = 50
    @low = 0
  end

  def start
    puts "Игра: отгадать число от 1 до 100"
    puts "Кто будет загадывать?\n" +
         "1. Вы\n" +
         "2. Компьютер\n" +
         "0. Выход\n"
    choice = gets.to_i
    case choice
    when 1
      player
    when 2
      computer
    else
      exit
    end
  end

  def computer
    puts 'За сколько попыток отгадаете?'
    tries = gets.to_i
    secret = rand(1..100)
    puts 'Я загадал число! Попробуйте его угадать:'
    number = gets.to_i
    1.upto(tries) do |i|
      puts "Попытка № #{i}"
      if secret == number
        return win
      elsif secret > number
        puts 'Мое число больше! Попробуйте еще: '
        number = gets.to_i
      else
        puts 'Мое число меньше! Попробуйте еще: '
        number = gets.to_i
      end
    end
    puts 'Вы не отгадали :('
    play_again
  end

  def player
    puts "Введите число от 1 до 100, которое хотите чтобы компьютер отгадал " +
         "(он, честно, не будет подсматривать)"
    secret = gets.to_i
    unless (1..100).include?(secret)
      puts 'Неверное число'
      start
    end
    puts 'Введите кол-во попыток компьютера'
    amount = gets.to_i
    1.upto(amount) do |i|
      puts "Попытка №#{i}\n" +
           "#{@mid}, это ваше число?\n" +
           "1. Да!\n" +
           "2. Нет, мое больше.\n" +
           "3. Нет, мое меньше.\n"
      input = gets.to_i
      case input
      when 1
        pc_victory
      when 2
        find_value(:higher)
      when 3
        find_value(:lower)
      end
    end
    lose
  end

  def find_value(user_answer)
    if user_answer == :lower
      @high = @mid - 1
      find_mid
    else
      @low = @mid + 1
      find_mid
    end
  end

  def find_mid
    @mid = (@low + @high) / 2
  end

  def pc_victory
    puts "Ура, я победил!"
    play_again
  end

  def win
    puts 'Вы отгадали!'
    play_again
  end

  def lose
    puts 'Я проиграл :('
    play_again
  end

  def play_again
    puts 'Сыграем еще? Y/N'
    exit if gets.chomp.downcase == 'n'
  end
end

loop do
  Game.new.start
end
