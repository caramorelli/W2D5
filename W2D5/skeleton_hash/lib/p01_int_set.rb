# We'll start with the first stage. In this version of a set, we can only store integers that live in a predefined range. So I tell you the maximum integer I'll ever want to store, and you give me a set that can store it and any smaller non-negative number.
#
# Initialize your MaxIntSet with an integer called max to define the range of integers that we're keeping track of.
# Internal structure:
# An array called @store, of length max
# Each index in the @store will correspond to an item, and the value at that index will correspond to its presence (either true or false)
# e.g., the set { 0, 2, 3 } will be stored as: [true, false, true, true]
# The size of the array will remain constant!
# The MaxIntSet should raise an error if someone tries to insert, remove, or check inclusion of a number that is out of bounds.
# Methods:
# #insert
# #remove
# #include?
class MaxIntSet
  def initialize(max)
    @store = Array.new(max, false)
  end

  def insert(num)
    validate!(num)
    @store[num] ? false : @store[num] = true
  end

  def remove(num)
    validate!(num)
    return nil unless include?(num)
    @store[num] = false
    num

  end

  def include?(num)
    validate!(num)
    @store[num]
  end

  private

  def is_valid?(num)
    num.between?(0, @store.length - 1)
  end

  def validate!(num)
    raise "Out of bounds" unless is_valid?(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    @store.include?(num) ? false : @store[num % num_buckets] << num
    num
  end

  def remove(num)
    @store[num % num_buckets].delete(num)
  end

  def include?(num)
    @store[num % num_buckets] == [num]
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    include?(num) ? false : @store[num % num_buckets] << num && @count +=1
    resize! if num_buckets < @count
    num
  end

  def remove(num)
    if include?(num)
      @store[num % num_buckets].delete(num)
      @count-=1
    end
  end

  def include?(num)
    @store[num % num_buckets] == [num]
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    original_arr = @store
    @count = 0
    @store = Array.new(num_buckets * 2) { Array.new }
    original_arr.flatten.each { |int| insert(int) }
  end

end
