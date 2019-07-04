def charscount(string, char)
  string.chars.inject(0) { |sum, el| sum += 1 if el == char; sum }
end

p charscount('Hello', 'l')
