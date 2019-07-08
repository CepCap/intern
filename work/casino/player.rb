class Player
  attr_accessor :bank, :placed_bet, :name, :bet, :status

  def initialize
    @name = ''
    @bank = 2000
    @status = :ingame
    @bet = 0
    @won = nil
  end

  def check_win(result)
    if @placed_bet == result.first || @placed_bet == result.last
      won(2) if @placed_bet.is_a? Symbol
      won(5) if @placed_bet.is_a?(Integer) && !@placed_bet == 0
      won(10) if @placed_bet == 0
    else
      lost
    end
  end

  def won(bet_multiplyer)
    @bank += @bet * bet_multiplyer
    @bet = 0
    @placed_bet_on = nil
    @won = true
  end

  def lost
    @bank -= @bet
    bet = 0
    status = :bankrupt if @bank <= 0
    @placed_bet_on = nil
    @won = false
  end

  def won?
    @won
  end

  def current_bet(value)
    @bank -= value
    @bet += value
  end

  def random_bet
    possible_bets = (0..36).to_a
    possible_bets << :red
    possible_bets << :black
    @placed_bet = possible_bets.sample
    bets = [10, 20, 30, 50, 100, 200, 500]
    @bet = bets.sample
  end

  def back_ingame
    @status = :ingame
  end
end
