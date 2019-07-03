class MyArray
  attr_accessor :init_arr

  def initialize(init_array)
    @init_arr = init_array
  end

  def my_length
    init_arr.each do |el|
      @count = 0 unless @count
      @count += 1
    end
    @count
  end

  def my_count(value)
    counting = 0
    init_arr.each do |el|
      counting += 1 if el == value
    end
    counting
  end

  def my_find(value)
    init_arr.each.with_index { |el, index| return index if el == value }
    nil
  end

  def my_map_find(value)
    init_arr.map.with_index { |el, index| index if el == value }.compact
  end

  def my_max
    current_max = init_arr[0]
    init_arr.each { |el| current_max = el if el > current_max }
    current_max
  end

  def my_select
    selected = []
    init_arr.each { |el| selected << el if el % 2 == 0 }
    selected
  end

  def my_reverse
    reverse = []
    init_arr.each { |el| reverse.unshift(el) }
    reverse
  end

  def my_flatten
    init_arr.each.with_index do |el, index|
      if el.is_a? Array
        init_arr.delete_at(index)
        flat(el, index)
      end
    end
  end

  def flat(array, index)
    array.each.with_index do |el, inner_index|
      init_arr.insert(index + inner_index, el)
    end
  end

  def try_all
    puts 'My length-------'
    p self.my_length
    puts 'My count--------'
    p self.my_count(40)
    puts 'My find (finding 50)-----'
    p self.my_find(50)
    puts 'My max------'
    p self.my_max
    puts 'My select-----'
    p self.my_select
    puts 'My reverse-----'
    p self.my_reverse
    puts 'My flatten-----'
    p self.my_flatten
  end
end

arr1 = MyArray.new([25, 7, 80 ,40])
arr2 = MyArray.new((1..100).to_a)
arr1.try_all
arr2.try_all
arr3 = MyArray.new([1,[1,2,3,[1,2,3,4]],3,4,5,6])
puts 'Flatten'
p arr3.my_flatten
