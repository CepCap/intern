def zip(arr1, arr2)
  if arr1.length > arr2.length
    longarr = arr1
    shortarr = arr2
  else
    longarr = arr2
    shortarr = arr1
  end
  longarr.map.with_index do |el, index|
    shortarr[index].nil? ? [el, nil] : [el, shortarr[index]]
  end
end

p zip([1,2,3,4,5], ['a','b','c'])
