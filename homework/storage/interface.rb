require_relative 'storage'

class Interface
  attr_accessor :storage

  def initialize(storage)
    @storage = storage
  end

  def menu
    puts '1. Вывести все товары'
    puts '2. Добавить новый товар'
    puts '3. Удалить существующий товар'
    puts '4. Изменить товар'
    puts '0. Выход'
    input = gets.chomp.to_i
    case input
    when 1
      show
    when 2
      add
    when 3
      delete
    when 4
      update
    when 0
      exit
    end
  end

  def show
    @storage.hash.each do |name, attributes|
      puts name.to_s +
          '; price -->' + attributes[:price].to_s +
          '; quantity -->' + attributes[:quantity].to_s +
          '; total price -->' + @storage.total_price(name).to_s
    end
    puts 'Total storage quantity: ' + @storage.total_storage_quantity.to_s
    puts 'Total storage price: ' + @storage.total_storage_price.to_s
  end

  def add
    puts 'Введите название товара:'
    name = gets.chomp.to_sym
    puts 'Введите цену:'
    price = gets.to_i
    puts 'Введите количество:'
    quantity = gets.to_i
    storage.add(name, MyHash.new([[:price, price], [:quantity, quantity]]))
  end

  def delete
    puts 'Введите наименование удаляемого продукта'
    storage.delete(gets.chomp.to_sym)
  end

  def update
    puts 'Введите наименование продукта'
    name = gets.chomp.to_sym
    puts "Введите изменяемый аттрибут:\n
          1) Цена\n
          2) Количество\n"
    input = gets.to_i
    case input
    when 1
      puts "Введите цену:"
      price = gets.to_i
      storage.hash[name][:price]= price
    when 2
      puts "Введите количество"
      quantity = gets.to_i
      storage.hash[name][:quantity]= quantity
    end
  end
end
