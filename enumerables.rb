module Enumerable
  def my_each
    return to_enum :name unless block_given?
    for element in self
      yield element
    end
  end

  def my_each_with_index
    return to_enum :name unless block_given?
    
    c = 0
    for element in self
      yield element, c
      c += 1
    end
  end

  def my_select
      return to_emum :my_select unless block_given?
        new_hash = {}
        new_array = []

        if is_a? (Hash)
          my_each do |x, y|
          new_hash[x] = y if yield(x, y)
        end
      return new_hash
        else
          my_each do |x|
          new_array.push(x) if yield(x) end
      end
      return new_array
  end

def my_all?(args = nil)
  return to_enum unless block_given? || !args.nil?
  arr = to_a
  if block_given?
    arr.my_each_with_index do |_item, index|
      return false unless yield arr[index]
    end
  elsif args.is_a? Class
    arr.my_each_with_index do |item, _index|
      return false unless item.class.ancestors.include?(args)
    end
  elsif args.is_a? Regexp
    arr.my_each_with_index do |item, _index|
      return false unless item.match(args)
    end
  end
  true
end

# print [1 ,3, 3, 4, 5, 6, 7].select

print [2, 8, 14, 52, 6, 72].my_all?{|x| x%2 ==0}end