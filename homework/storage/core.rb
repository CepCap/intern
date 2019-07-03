require_relative 'interface'

seed = MyHash.new([[:bananas, MyHash.new([[:quantity, 40], [:price, 500]]) ],
                   [:tomatoes, MyHash.new([[:quantity, 20], [:price, 123]]) ]])

storage = Storage.new(seed)
interface = Interface.new(storage)
loop do
  interface.menu
end
