class EmptyArr
  attr_accessor :init_arr

  def initialize
    @init_arr = []
  end

  def while_fill
    while @init_arr.length < 50
      a[0] = 1 if arr.empty?
      @init_arr << @init_arr[-1] + 1
    end
    @init_arr
  end

  def each_fill
    a[0] = 1 if arr.empty?
    @init_arr.each do |num|
      @init_arr << @init_arr[-1] + 1 unless @init_arr[-1] == 50
    end
    @init_arr
  end

  def map_fill
    @init_arr[49] = nil
    @init_arr.map.with_index do |num, i|
     i + 1
    end
  end
end

p EmptyArr.new.while_fill
p EmptyArr.new.each_fill
p EmptyArr.new.map_fill
