module TwoArrays
  def self.my_merge(arr1, arr2)
    merged = Array.new(arr1.length + arr2.length)
    arr1.each.with_index { |el, index| merged[index] = el }
    arr2.each.with_index { |el, index| merged[index + arr1.length] = el }
    merged
  end
end

p TwoArrays.my_merge([1,2,3], [1,2,3,4,5])
