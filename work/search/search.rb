require 'find'

def find_file(path = '/**/', filename)
  path += '/**/' unless path == '/**/'
  filename = "*#{filename}" if filename[0] == '.'
  path += filename
  found = Dir.glob(path)
  File.open('last_search_results', 'wb') { |f| f.puts found.join("\n") }
  found
end


p find_file('/Users/cepcap/Desktop/work', 'search.rb')
p find_file('school.rb')
p find_file('.pdf')
p find_file('/Users/cepcap/Desktop', '.pdf')
