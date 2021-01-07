rubocop:disable Style/CaseEquality
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
        my_each {|x| return true if yield(x)}
      else
        my_each {|x| return true if x}
      end
    elsif args.is_a?(Regexp)
      my_each {|x| return true if x.match(args)}
    elsif args.is_a?(Module)
      my_each {|x| return true if x.is_a?(args)}
    else
      my_each {|x| return true if x == args}
    end
    false
  end

  def my_none?(args = nil)
    if args.nil?
      if block_given?
        my_each {|x| return false if yield(x)}
      else
        my_each {|x| return false if x}
      end
    elsif args.is_a?(Regexp)
      my_each {|x| return false if x.match(args)}
    elsif args.is_a?(Module)
      my_each {|x| return false if x.is_a?(args)}
    else
      my_each {|x| return false if val == args}
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

  def my_map(args = nil)
    return to_enum :mapping unless block_given?

    r_arr = []
    if block_given? && args.is_a?(Proc)
      my_each do |x|
        r_arr << args.call(x)
      end
    elsif !block_given? && args.is_a?(Proc)
      my_each do |x|
        r_arr << args.call(x)
      end
    else
      my_each do |x|
        r_arr << yield(x)
      end
    end
    r_arr
  end

  def my_inject(arg1 = nil, arg2 = nil)
    y = nil
    s = nil
    if arg1.is_a?(Numeric)
      y = arg1
      s = arg2 if arg2.is_a?(Symbol)
    end
    s = arg1 if arg1.is_a?(Symbol)
    if !symbol.nil?
      my_each do |x|
        y = y ? acc.send(s, x) : val
      end
    else
      my_each do |x|
        y = y ? yield(y, x) : val
      end
    end
    y
  end
end


# This method is only for tests
def multiply_els(args)
  args.my_inject { |acc, val| acc * val }
end