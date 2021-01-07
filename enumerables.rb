module Enumerable
  def my_each
    for element in self
      yield element
    end
  end

end
