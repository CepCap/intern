class XML
  def method_missing(m, *args, &block)
    "<#{m}> " + args.join('') + "</#{m}>"
  end
end

a = XML.new
p a.foo
p a.b('hello', ' world ')
p a.b(123, [], {})
p a.div(22142) {}
