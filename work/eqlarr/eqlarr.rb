def eqlarr(arr1, arr2)
  return false if arr1.length != arr2.length
  arr1.each.with_index { |el, index| return false if el != arr2[index] }
  true
end

def no_return_eqlarr(arr1, arr2)
  result = false if arr1.length != arr2.length
  unless result == false
    arr1.each.with_index { |el, index| result = false if el != arr2[index] }
  end
  result = true unless result == false
  result
end

p eqlarr([1,2,3], [1,2,3])
p eqlarr([1,2,3], [3,4,1])
p eqlarr([1],[1,2,3,4,5])
p eqlarr([1,23,4,5],[1,23])
puts 'No return'
p no_return_eqlarr([1,2,3], [1,2,3])
p no_return_eqlarr([1,2,3], [3,4,1])
p no_return_eqlarr([1],[1,2,3,4,5])
p no_return_eqlarr([1,23,4,5],[1,23])
