class Chess
  def initialize
    @black = 'X'
    @white = 'O'
    @row = (@black + @white) * 4
    @letters = ('A'..'H').to_a
    @numbers = (1..8)
    @corner = ' '
  end

  def board
    @board = [@corner + @letters.join + "\n"]
    @numbers.each do |num|
      @row.reverse!
      @board << num.to_s + @row + "\n"
    end
    @board
  end

end

puts Chess.new.board
