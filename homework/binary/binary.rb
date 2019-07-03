module BinarySearch
  def self.search(array, value)
    @low = 1
    @high = array.length
    find_mid
    until array[@mid] == value
      if array[@mid] < value
        low = @mid - 1
        find_mid
      elsif array[@mid] > value
        high = @mid + 1
        find_mid
      end
    end
    @mid
  end

  def self.find_mid
    @mid = @low + (@high - @low) / 2
  end
end

p BinarySearch.search([1,23,64,34,45,457,98,345], 45)
p BinarySearch.search([1,2,3,4,5], 4)
