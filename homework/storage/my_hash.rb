class MyHash
  attr_accessor :arr

  def initialize(array)
    @arr = array
  end

  def [](key)
    arr.find { |el| el.first == key }[1]
  end

  def []=(key, value)
    if arr.find { |el| el.first == key }
      arr.find { |el| el.first == key }[1] = value
    else
      arr << [key, value]
    end
  end

  def keys
    arr.map(&:first)
  end

  def key
    arr[0]
  end

  def values
    arr.map(&:last)
  end

  def delete(key)
    arr.delete_if { |el| el.first == key }
  end

  def each
    i = 0
    while i < arr.length do
      yield(arr[i].first, arr[i].last)
      i += 1
    end
    arr
  end

  def find
    i = 0
    while i < arr.length do
      return arr[i] if yield(arr[i])
    end
  end

  def map
    i = 0
    map_arr = []
    while i < arr.length do
      map_arr << yield(arr[i])
      i += 1
    end
    map_arr
  end
end
