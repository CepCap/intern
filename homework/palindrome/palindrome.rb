class String
  def palindrome?
    self == self.reverse
  end
end

p 'abcba'.palindrome?
p 'aaabb'.palindrome?
