require 'find'

def find_file(search_path = false, filename)
  if search_path
    search_path = ENV['HOME'] + "/#{search_path}"
  else
    search_path = ENV['HOME']
  end
  found_paths = []
  Find.find(search_path) do |path|
    if filename[0] == '.'
      begin
        files = Dir[path + "/*#{filename}"]
        found_paths << files unless files.empty?
      rescue Errno::EOPNOTSUPP
        Find.prune
      end
    else
      found_paths << path + "/#{filename}" if File.file?(path + "/#{filename}")
    end
  end
  found_paths.flatten!
  if search_path == ENV['HOME']
    filename = "results_of_search_#{filename}.txt"
  else
    filename = "results_of_folder_search_#{filename}.txt"
  end
  File.open(filename, 'wb') { |f| f.puts found_paths.join("\n") }
  found_paths
end


p find_file('Desktop/work/work/search', 'search.rb')
p find_file('school.rb')
p find_file('.pdf')
p find_file('Desktop', '.pdf')
