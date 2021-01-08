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
        my_each { |x| return true if yield(x) }
      else
        my_each { |x| return true if x }
      end
    elsif args.is_a?(Regexp)
      my_each { |x| return true if x.match(args) }
    elsif args.is_a?(Module)
      my_each { |x| return true if x.is_a?(args) }
    else
      my_each { |x| return true if x == args }
    end
    false
  end

  def my_none?(args = nil)
    if args.nil?
      if block_given?
        my_each { |x| return false if yield(x) }
      else
        my_each { |x| return false if x }
      end
    elsif args.is_a?(Regexp)
      my_each { |x| return false if x.match(args) }
    elsif args.is_a?(Module)
      my_each { |x| return false if x.is_a?(args) }
    else
      my_each { |x| return false if x == args }
    end
    true
  end

  def my_select
    return to_enum :my_select unless block_given?

    new_hash = {}
    new_array = []

    if is_a?(Hash)
      my_each do |x, y|
        new_hash[x] = y if yield(x, y)
      end
      return new_hash
    else
      my_each do |x|
        new_array.push(x) if yield(x)
      end
    end
    new_array
  end

  def my_all?(args = nil)
    arr = to_a
    if block_given?
      arr.my_each_with_index do |_item, index|
        return false unless yield arr[index]
      end
    elsif args.nil?
      my_each { |x| return false if x.nil? || x == false }
    elsif args.is_a? Class
      arr.my_each_with_index do |item, _index|
        return false unless item.class.ancestors.include?(args)
      end
    elsif args.is_a? Regexp
      arr.my_each_with_index do |item, _index|
        return false unless item.match(args)
      end
    else
      my_each { |n| return false if n != args }
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
    if block_given?
      acc = arg1
      my_each do |x|
        acc = acc.nil? ? x : yield(acc, x)
      end
      acc
    elsif !arg1.nil? && (arg1.is_a?(Symbol) || arg1.is_a?(String))
      acc = nil
      my_each do |x|
        acc = acc.nil? ? x : acc.send(arg1, x)
      end
      acc
    elsif !arg2.nil? && (arg2.is_a?(Symbol) || arg2.is_a?(String))
      acc =  arg1
      my_each do |x|
        acc = acc.nil? ? x : acc.send(arg2, x)
      end
      acc
    end
  end

  def my_count(arg = nil)
    count = 0
    if block_given?
      my_each do |x|
        count += 1 if yield(x)
      end
    elsif arg.nil?
      count = size
    else
      my_each do |x|
        count += 1 if x == arg
      end
    end
    count
  end
end

print [1, true, "hi", []].all? == [1, true, "hi", []].my_all?
# This method is only for tests
def multiply_els(args)
  args.my_inject { |acc, val| acc * val }
end
