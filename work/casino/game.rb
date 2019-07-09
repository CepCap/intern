require_relative 'player'

class Game
  attr_reader :player, :comp_players, :winner

  def initialize
    @player = Player.new
    @comp_players = []
    @bet_multiplyer = { even: 0, color: 0, zero: 0, numeral: 0 }
    @board = { 1 => :red, 2 => :black, 3 => :red, 4 => :black, 5 => :red, 6 => :black,
               7 => :red, 8 => :black, 9 => :red, 10 => :black, 11 => :black, 12 => :red,
               13 => :black, 14 => :red, 15 => :black, 16 => :red, 17 => :black,
               18 => :red, 19 => :red, 20 => :black, 21 => :red, 22 => :black,
               23 => :red, 24 => :black, 25 => :red, 26 => :black, 27 => :red,
               28 => :black, 29 => :black, 30 => :red, 31 => :black, 32 => :red,
               33 => :black, 34 => :red, 35 => :black, 36 => :red, 0 => nil }
  end

  def generate_comp_players(amount)
    amount.times do |i|
      comp = Player.new
      comp.name = "Computer#{i+1}"
      @comp_players << comp
    end
  end

  def round_begin
    @comp_players.each do |player|
      player.random_bet
    end
  end

  def round_end
    @winner = @board.to_a.sample
    @player.check_win(winner)
    @comp_players.each do |player|
      player.check_win(winner)
    end
    @comp_players.delete_if { |player| player.status == :bankrupt }
  end
end
