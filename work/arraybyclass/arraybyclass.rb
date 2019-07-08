def classes_in_array(array)
  by_class = Hash.new
  array.each do |el|
    if by_class[el.class]
      by_class[el.class] << el
    else
      by_class[el.class]= [el]
    end
  end
  by_class.values
end

# def not_working?(array)
#   by_class = Hash.new([])
#   array.each do |el|
#     by_class[el.class] << el
#   end
#   by_class.values
# end

p classes_in_array([:foo, 1, 10001, 'foo', 'badfadsf', 1212, :erer, {}, []])
