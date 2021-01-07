module Enumerable
  def my_each
    return to_enum :yourname unless block_given?

    for element in self
      yield element
    end
  end

  def my_each_with_index
    return to_enum :yourname unless block_given?
    
    c = 0
    for element in self
      yield element, c
      c += 1
    end
  end

end

[1 ,3, 3, 4, 5, 6, 7].my_each 
[1 ,3, 3, 4, 5, 6, 7].my_each_with_index 
[1 ,3, 3, 4, 5, 6, 7].select
