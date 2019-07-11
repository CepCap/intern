require 'benchmark'

def numbers_generator(file, amount)
  count = amount / 10
  last_row = amount % 10
  File.open(file, 'wb') do |f|
    count.times do
      10.times do
        f.print (rand(10 ** 2).to_s + ' ')
      end
      f.puts
    end
    last_row.times do
      f.puts (rand(10 ** 2).to_s + ' ')
    end
  end
end

files = [ '50', '10k', '50k', '100k' ]

puts '10k'
numbers_generator('10k', 10 ** 4)
puts '50k'
numbers_generator('50k', 10 ** 4 * 5)
puts '100k'
numbers_generator('100k', 10 ** 5)
puts '50'
numbers_generator('50', 10 * 5)



def sort_files(files)
  files.each do |file|
    sorted = File.open(file + "_sorted", 'wb')
    begin
      File.open(file, 'r') do |f|
        while line = f.read
          sorted.puts bubble_sort(line.split(' ').map(&:to_i)).join(' ')
        end
      end
    rescue EOFError
    end
    sorted.close
  end
end

def bubble_sort(array)
  swapped = false
  loop do
    array.each.with_index do |el, index|
      next if index == array.length - 1
      if el > array[index + 1]
        array[index], array[index + 1] = array[index + 1], array[index]
        swapped = true
      end
    end
    break if swapped == false
    swapped = false
  end
  array
end

p a = [5,4,3,2,1]
p b = [123, 789, 456, 0, 100]

p bubble_sort(a) == [1, 2, 3, 4, 5]
p bubble_sort(b) == [0, 100, 123, 456, 789]

results = Benchmark.bm do |x|
  x.report('10k:') { sort_files(['10k']) }
  # x.report('50k:') { sort_files(['50k']) }
  # x.report('100k:') { sort_files(['100k']) }
end

File.open('benchmark', 'wb') do |f|
  f.puts results
end

sort_files(files)
