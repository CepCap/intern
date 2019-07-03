require_relative 'my_hash'

class Storage
  attr_accessor :hash

  def initialize(my_hash)
    @hash = my_hash
  end

  def find_by_name(name)
    hash.find { |el| el.first == name }
  end

  def names
    hash.map { |el| el[0] }
  end

  def prices
    hash.map { |el| el[1][1] }
  end

  def quantities
    hash.map { |el| el[1][0] }
  end

  def quantity(name)
    find_by_name(name)[1].find { |el| el.first == :quantity }
  end

  def price(name)
    find_by_name(name)[1].find { |el| el.first == :price }
  end

  def delete(name)
    delete(name)
  end

  def update(type, value)
    case type
    when :name
      find_by_name(name)[0] = value
    when :price
      find_by_name(name)[1][1] = value
    when :quantity
      find_by_name(name)[0][1] = value
    end
  end
end
