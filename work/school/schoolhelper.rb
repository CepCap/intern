module SchoolHelper
  def find_median(array)
    (array.sum.to_f / array.length.to_f).round(2)
  end
end
