class MyArray
  attr_accessor :arr

  def initialize(array)
    @arr = array
  end

  def includes?(value)
    @arr.each { |el| return true if el == value }
  end
end

p MyArray.new([1,2,3,4,5]).includes?(3) == true
p MyArray.new([1,2,3,4,5]).includes?(60) == false
p MyArray.new([]).includes?(3) == false
