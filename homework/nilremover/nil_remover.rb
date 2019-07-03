# Как избавиться от nil в данном примере, напишите реализацию
#  [nil,123,nil,"test", :foo, :bar]

array = [nil,123,nil,"test", :foo, :bar]
p array.select { |el| el }
