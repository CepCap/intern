class MyArray
  attr_accessor :init_arr

  def initialize(array)
    @init_arr = array
  end

  def max2
    init_arr.drop(2).inject([init_arr[0], init_arr[1]]) do |max2, el|
      if el <= max2[0] && el >= max2[1]
        max2[1] = el
      elsif el >= max2[0]
        max2[0] = el
      end
      max2
    end
  end

  def silly_max2
    @init_arr.sort[-2..-1]
  end

  def my_uniq
    uniq_arr = []
    init_arr.each { |el| uniq_arr << el unless uniq_arr.include? el }
    uniq_arr
  end
end

arr1 = MyArray.new([1,5,3,4,5])
arr2 = MyArray.new([5,4,3,2,1])
arr3 = MyArray.new([6,6,6,6,6])
# p arr1.silly_max2
# p arr2.silly_max2
p arr1.max2 #== [5, 5]
p arr2.max2 #== [5, 4]
p arr3.max2 #==
# p arr1.my_uniq
# p arr2.my_uniq
# p arr3.my_uniq
