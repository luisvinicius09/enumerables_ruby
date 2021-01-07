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

  def my_any?(args = nil)
    if args.nil?
      if block_given?
        my_each {
          |x| if yield(x) return true end
        }
      else
        my_each {
          |x| if x return true end
        }
      end
    elsif args.is_a?(Regexp)
      my_each {
        |x| if x.match(args) return true end
      }
    elsif args.is_a?(Module)
      my_each {
        |x| if x.is_a?(args) return true end
      }
    else
      my_each {
        |x| if x == args return true end
      }
    end
    false
  end

  def my_none?(args = nil)
    if args.nil?
      if block_given?
        my_each {
          |x| if yield(x) return false end
        }
      else
        my_each {
          |x| if x return false end
        }
      end
    elsif args.is_a?(Regexp)
      my_each {
        |x| if x.match(args) return false end
      }
    elsif args.is_a?(Module)
      my_each {
        |x| if x.is_a?(args) return false end
      }
    else
      my_each {
        |x| if val == args return false end
      }
    end
    true
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

  def my_count(arg = nil)
   count = 0
    if block_given?
      my_each do |x|
        count += 1 if yield (x)end
    elsif arg.nil?
      count = size
    else
      my_each do |x|
        count += 1 if x == arg end
    end
  return count
  end

end
print [6 ,4, 3, 2, 98, 53, 3, 3, 7,265,2].my_count(3)