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
          |x| if yield(x)
                false
              end
        }
      else
        my_each {
          |x| if x
                false
              end
        }
      end
    elsif args.is_a?(Regexp)
      my_each {
        |x| if x.match(args)
              false
            end
      }
    elsif args.is_a?(Module)
      my_each {
        |x| if x.is_a?(args)
              false
            end
      }
    else
      my_each {
        |x| if val == args
              false
            end
      }
    end
    true
  end

end

# [1 ,3, 3, 4, 5, 6, 7].my_each 
# [1 ,3, 3, 4, 5, 6, 7].my_each_with_index 
print [1, 2, 3, 4, 5].my_any? {|number| number % 2 == -1}


