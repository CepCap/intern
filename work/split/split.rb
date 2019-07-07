def my_chars(string)
  chars_i = 0
  chars = []
  while chars_i < string.length do
    chars << string[chars_i]
    chars_i += 1
  end
  chars
end

def my_split(string, input)
  return 'Please enter a string' unless input.is_a?(String) && string.is_a?(String)
  chars = my_chars(string)
  result = []
  resulting_string = ''
  sequence = ''
  sequence_iterator = 0
  chars.each do |char|
    if char == input[sequence_iterator]
      sequence += char
      sequence_iterator += 1
      if sequence == input
        result << resulting_string
        resulting_string = ''
        sequence = ''
        sequence_iterator = 0
      elsif sequence != input && sequence_iterator == (input.length + 1)
        resulting_string += sequence
        sequence = ''
        sequence_iterator = 0
      end
    else
      resulting_string += char
    end
  end
  result
end


p my_split('Ifff amfff workingfff correctlyfff', 'fff')
