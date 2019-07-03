class Array
  def my_each
    i = 0
    while i < self.length
      yield(self[i])
      i += 1
    end
  end

  def my_map
    i = 0
    array = []
    while i < self.length
      array << yield(self[i])
      i += 1
    end
    array
  end
end


class MyArray
  attr_accessor :arr

  def initialize(array)
    @arr = array
  end

  def my_find
    arr.my_each { |el| return el if yield(el) == true }
    nil
  end

  def my_select
    arr.my_map { |el| el if yield(el) == true }.compact
  end

  def my_count
    count = 0
    arr.my_each { |el| count += 1 if yield(el) }
    count
  end
end

arr1 = MyArray.new([1,2,3,4,5])

p arr1.arr.my_each { |el| puts "Inside my each with #{el}" }
p arr1.arr.my_map { |el| puts "Changed #{el} to nil!" }
p arr1.my_find { |el| el > 3 } == 4
p arr1.my_select { |el| el > 3 } == [4,5]
p arr1.my_count { |el| el > 3 } == 2
