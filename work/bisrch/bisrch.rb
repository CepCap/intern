def bisrch(arr, find_value)
  arr.sort!
  loop do
    mid = arr.length/2
    break if mid.zero?
    if arr.length == 2
      if arr[0] == find_value
        break true
      elsif arr[1] == find_value
        break true
      else
        break false
      end
    end
    mid_el = arr[mid]
    if mid_el == find_value
      break true
    elsif mid_el > find_value
      arr = arr[0..mid]
    else
      arr = arr[mid..-1]
    end
  end
end

p bisrch([1,2,3,4,5], 1)
p bisrch([1,2,3,4,5], 5)
p bisrch((1..500000).to_a, 23425)
p bisrch([2,3,76,345,323,4346,457,54,63], 63)
p bisrch([12432,436457457,243436456,2341231231], 1)
