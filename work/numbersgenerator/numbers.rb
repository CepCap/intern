def uniqate(array)
  array.inject([]) { |uniq, el| uniq << el unless uniq.include? el; uniq }
end

def numbers_generator(file, amount)
  File.open(file, 'wb') do |f|
    amount.times do
      f.print (rand(10 ** 3).to_s + ' ')
    end
  end
end

def has_dups?(file)
  File.read(file).split(' ').inject([]) do |uniq, el|
    return true if uniq.include? el
    uniq << el
  end
  false
end

def no_dups(file)
  uniqate(File.read(file).split(' ')).each do |el|
    File.open(file + '_no_dups', 'w+') do |f|
      f.print el.to_s + ' '
    end
  end
end

p uniqate([6,6,6,6,6]) == [6]
p uniqate([6,7,8,6,6]) == [6,7,8]
filename = 'generated_numbers'
numbers_generator(filename, 10*7)
p has_dups?(filename)
if has_dups?(filename)
  no_dups(filename)
end
p has_dups?("#{filename}_no_dups") == false
