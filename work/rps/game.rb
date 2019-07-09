class Game
  attr_reader :win_condition, :generate_choice
  attr_accessor :player1_wins, :player2_wins, :comp_choice,
                :round_results, :comp_games_amount

  def initialize
    @win_condition = { rock: :scissors, paper: :rock, scissors: :paper }
    @generate_choice = ['rock', 'paper', 'scissors']
    @comp_games_amount = 1000
    initialize_choices
    @comp_choices = File.new('comp_choices')
    @comp_choice = 0
    @player1_wins = 0
    @player2_wins = 0
  end

  def pvc(choice)
    choice2 = ''
    File.open('comp_choices', 'r') do |f|
      choice2 = f.readlines[comp_choice].split(' ').first.to_sym
    end
    @comp_choice += 1
    check_win(choice, choice2)
  end

  def check_win(input1, input2)
    if win_condition[input1] == input2
      @player1_wins += 1
      result = :player1
    elsif win_condition[input1] == win_condition[input2]
      result = :draw
    else
      result = :player2
      @player2_wins += 1
    end
    @round_results = {winner: result, player_input: input1.to_s, comp_input: input2.to_s}
  end

  def percentage
    p1 = @player1_wins.to_f / @comp_games_amount.to_f * 100.00
    p2 = @player2_wins.to_f / @comp_games_amount.to_f * 100.00
    [p1.to_i, p2.to_i]
  end

  def cvc
    begin
      File.open('comp_choices', 'r') do |f|
        while choice = f.readline.split(' ')
          check_win(choice[0].to_sym, choice[1].to_sym)
        end
      end
    rescue EOFError
    end
  end

  def initialize_choices
    File.open('comp_choices', 'wb') do |f|
      @comp_games_amount.times do
        f.puts generate_choice.sample + ' ' + generate_choice.sample
      end
    end
  end

  def game_end
    @comp_choice = 0
    @player1_wins = 0
    @player2_wins = 0
  end
end
