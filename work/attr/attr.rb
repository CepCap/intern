class Foo
  class << self
    def my_attr_reader(*args)
      args.each do |el|
        define_method(el) do
          instance_variable_get("@#{el}")
        end
      end
      nil
    end

    def my_attr_writer(*args)
      args.each do |el|
        define_method("#{el}=") do |arg|
          instance_variable_set("@#{el}", arg)
        end
      end
      nil
    end

    def my_attr_accessor(*args)
      args.each do |el|
        define_method(el) do
          instance_variable_get("@#{el}")
        end
        define_method("#{el}=") do |arg|
          instance_variable_set("@#{el}", arg)
        end
      end
      nil
    end
  end
end

class Baz < Foo
  my_attr_reader :hello
  my_attr_writer :pen
  my_attr_accessor :world
  def initialize
    @hello = 'Hello!'
  end

  def method_missing(method, *args, &block)
    puts "Method #{method} is not working!"
  end
end

test = Baz.new
puts 'test.hello is working?'
p test.hello == 'Hello!'
puts 'test.pen= is working?'
p test.pen=('10') == '10'
puts 'test.world, test.world= is working?'
p (test.world=('Round')) == 'Round'
p test.world == 'Round'

test.pen
(test.hello = 'Not gonna work')
