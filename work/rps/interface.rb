require_relative 'game'

class Interface
  attr_reader :game
  attr_accessor :player_name

  def initialize
    @game = Game.new
  end

  def start
    unless player_name
      puts "Введите Ваше имя: "
      @player_name = gets.chomp
    end
    puts "Выберите режим:\n" +
         "1. Игрок против Компьютера.\n" +
         "2. Компьютер против Компьютера.\n" +
         "3. Обновить выбор Компьютера.\n" +
         "0. Выход"
    choice = gets.to_i
    case choice
    when 1
      player_vs_comp
    when 2
      comp_vs_comp
    when 3
      reinitialize
    else
      exit
    end
  end

  def reinitialize
    puts 'Введите кол-во игр: '
    amount = gets.to_i
    if amount.zero?
      puts 'Неверное значение'
      reinitialize
    end
    game.comp_games_amount
    game.initialize_choices
  end

  def player_vs_comp
    puts "Выберите:\n" +
         "1. Камень\n" +
         "2. Ножницы\n" +
         "3. Бумага\n"
    choice = gets.to_i
    case choice
    when 1
      game.pvc(:rock)
    when 2
      game.pvc(:scissors)
    when 3
      game.pvc(:scissors)
    else
      start
    end
    winner = game.round_results[:winner]
    player_input = game.round_results[:player_input]
    comp_input = game.round_results[:comp_input]
    if winner == :player1
      puts "#{@player_name} Выиграл!"
    elsif winner == :player2
      puts "Компьютер Выиграл!"
    else
      puts "Ничья!"
    end
    puts "#{@player_name} выбрал #{player_input}, Компьютер выбрал #{comp_input}"
    puts "Ваши победы: #{game.player1_wins}, Победы компьютера: #{game.player2_wins}"
    puts "Сыграем еще? Y/N"
    choice = gets.chomp.downcase
    choice == 'y' ? player_vs_comp : game.game_end
  end

  def comp_vs_comp
    game.cvc
    if game.player1_wins == game.player2_wins
      puts 'Ничья!'
    elsif game.player1_wins > game.player2_wins
      puts 'Комп.1 выиграл!'
    else
      puts 'Комп.2 выиграл!'
    end
    puts "Комп1 победы: #{game.player1_wins}, Процент побед: #{game.percentage.first}"
    puts "Комп2 победы: #{game.player2_wins}, Процент побед: #{game.percentage.last}"
    game.game_end
  end
end
