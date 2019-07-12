module SchoolHelper
  def find_median(array)
    (array.sum.to_f / array.length.to_f).round(2)
  end

  def readfile(filename)
    File.open(filename, 'r') { |f| yield(f) }
  end

  def writefile(filename)
    File.open(filename, 'wb') { |f| yield(f) }
  end
end
