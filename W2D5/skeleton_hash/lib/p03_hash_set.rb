class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    key_indx = key.hash
    @store.include?(key) ? false : @store[key_indx % num_buckets] << key && @count += 1
    resize! if num_buckets < @count

  end

  def include?(key)
    #key_indx = key.hash
    @store.include?([key]) || @store.include?(key)
  end

  def remove(key)
    if include?(key)
      @store[key % num_buckets].delete(key)
      @count-=1
    end
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
    count = 0
    @store = Array.new(num_buckets * 2) { Array.new }

    original_arr.flatten.each { |int| @store << int }
  end

end
