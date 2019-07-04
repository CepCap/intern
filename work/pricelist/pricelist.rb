price_list1 = {'яблоки' => 100, 'груши' => 13, 'арбузы' => 20, 'картофель' => 15, 'алыча' => 22}
price_list2 = {'яблоки' => 150, 'груши' => 18,'ананасы' => 45, 'апельсины' => 30, 'киви' => 35}

p price_list1.merge(price_list2) do |name, value1, value2|
  value1 if value1 > value2
end
