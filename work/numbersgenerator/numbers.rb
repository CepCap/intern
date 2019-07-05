def uniqate(array)
  array.inject([]) { |uniq, el| uniq << el unless uniq.include? el; uniq }
end

def numbers_generator(file, amount)
  File.open(file, 'wb') do |f|
    amount.times do
      f.print (rand(10 ** 2).to_s + ' ')
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
  File.open(file + '_no_dups', 'wb') do |f|
    f.puts uniqate(File.read(file).split(' ')).join(' ')
  end
end

puts 'Uniqate tryout'
p uniqate([6,6,6,6,6]) == [6]
p uniqate([6,7,8,6,6]) == [6,7,8]
filename = 'generated_numbers'
puts 'Generating numbers...'
numbers_generator(filename, 10 ** 7)
puts 'Checking for dups'
dups = p has_dups?(filename)
if dups
  puts 'Making no-dups copy'
  no_dups(filename)
end
puts 'Checking if "_no_dups" dont have dups'
puts has_dups?("#{filename}_no_dups") == false
