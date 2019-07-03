def zip(arr1, arr2)
  if arr1.length > arr2.length
    longarr = arr1
    shortarr = arr2
  else
    longarr = arr2
    shortarr = arr1
  end
  combined = []
  longarr.each.with_index do |el, index|
    if shortarr[index].nil?
      combined << el
    else
      combined << el
      combined << shortarr[index]
    end
  end
  combined
end

p zip([1,2,3,4,5], ['a','b','c'])
