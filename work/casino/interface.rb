require_relative 'game'

class Interface
  def initialize
    @game = Game.new
  end

  def start
    puts 'Добро пожаловать в наше казино! Как Вас зовут?'
    @game.player.name = gets.chomp
    puts "Очень приятно, #{@game.player.name}. Введите количество соперников: "
    @game.generate_comp_players(gets.to_i)
    puts 'Давайте играть!'
    sleep 1
    round
  end

  def round
    puts "Ваши соперники: "
    @game.comp_players.each do |player|
      puts "#{player.name}:  Банк = #{player.bank}"
    end
    puts "Делайте ваши ставки!"
    puts "Выберите число или цвет (красный или черный)."
    input = gets.downcase.chomp
    if input == 'красный'
      @game.player.placed_bet = :red
    elsif input == 'черный'
      @game.player.placed_bet = :black
    else
      @game.player.placed_bet = input.to_i
    end
    puts "Введите сумму ставки"
    @game.player.bet = gets.to_i
    puts "Ваши соперники: "
    @game.round_begin
    @game.comp_players.each do |player|
      puts "#{player.name}:  Банк = #{player.bank}, Ставка: #{player.placed_bet}," +
           "Сумма ставки: #{player.bet}"
    end
    puts "Ставки сделаны..."
    sleep 0.5
    puts '...'
    sleep 0.5
    puts '...'
    sleep 0.5
    @game.round_end
    puts "#{@game.winner.join(' ')}!"
    puts "Вы #{@game.player.won? ? 'победили' : 'проиграли' }"
    puts "Ваш банк: #{@game.player.bank}"
    bankrupt if @game.player.bank <= 0
    puts "Сыграем еще? Y/N"
    input = gets.downcase.chomp
    input == 'y' ? round : exit
  end

  def bankrupt
    puts "Вы - банкрот."
    puts "Начать сначала? Y/N"
    gets.chomp.downcase == 'y' ? start : exit
  end
end
