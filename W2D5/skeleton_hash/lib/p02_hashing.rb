class Fixnum
  # Fixnum#hash already implemented for you
end

class Array

  def hash

  end
end

class String
  def hash
    new_hash = []
    (self.chars).each_with_index do |ele, indx|
      new_hash << Integer(ele.unpack('B')) + indx
    end
    print new_hash
    puts '***************'
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    0
  end
end
