def count_words(text)
  arr = text.split(/\W/).reject(&:empty?)
  words_hash = Hash.new(0)
  arr.each do |word|
    words_hash[word] += 1
  end
  words_hash.sort_by { |key, value| value }
end

macbeth = File.read('macbeth.txt')

p count_words(macbeth)
