require_relative 'my_hash'

class Storage
  attr_accessor :hash

  def initialize(my_hash)
    @hash = my_hash
  end

  def add(name, attributes)
    @hash[name]= attributes
  end

  def delete(name)
    @hash.delete(name)
  end

  def update(name, attribute)
    @hash[name]= attribute
  end

  def total_quantity
    @hash.map do |el|
      el[1][:quantity]
    end.inject(&:+)
  end

  def total_price
    @hash.map do |el|
      el[1][:price]
    end.inject(&:+)
  end
end
