require_relative '../enumerables.rb'


describe Enumerable do

  let(:array) { [1, 2, 3, 4, 5, 7, 8, 22, 55, 34, 86] }
  let(:all_odd_array) { [1, 3, 5, 7, 9, 11] }
  let(:negative_array) { [-8, -9, -6] }
  let(:false_array) { [1, false, 'hi', []] }
  procc = Proc.new{|element| element * 10}
  range = 1..5

  # my_each -- array
  describe '#my_each' do
    it 'return an array' do
      expect(array.my_each{|element| element * 2}).to eq(array.each{|element| element * 2})
    end
  end

  # my_each -- range
  describe '#my_each' do
    it 'return an array' do
      expect(range.my_each{|x| x.even?}).to eq(range.each{|x| x.even?})
    end
  end

  #my_each_with_index -- array
  describe '#my_each_with_index' do
    it 'return an array' do
      expect(array.my_each_with_index{|x| x * 12}).to eq(array.each_with_index{|x| x * 12})
    end
  end

  #my_any? -- false_array
  describe '#my_any?' do
    it 'return true' do
      expect(false_array.my_any?(Numeric)).to eq(false_array.any?(Numeric))
    end
  end

  #my_any? -- array
  describe '#my_any?' do
    it 'return false'do
      expect(array.my_any?(String)).to eq(array.any?(String))
    end
  end

  #my_none? -- false_array
  describe '#my_none?' do
    it 'return true' do
      expect(false_array.my_none?(Numeric)).to eq(false_array.none?(Numeric))
    end
  end

  #my_none? -- array
  describe '#my_none?' do
    it 'return false'do
      expect(array.my_none?(String)).to eq(array.none?(String))
    end
  end

  # my_select -- array
  describe '#my_select' do
    it 'my_select should return even array' do
      expect(array.my_select(&:even?)).to eq(array.select(&:even?))
    end
  end

  # my_select -- range
  describe '#my_select' do
    it 'my_select should return even array from range' do
      expect(range.select(&:even?)).to eq(range.select(&:even?))
    end
  end

  # my_all -- array
  describe '#my_all?' do
    it 'my_all should return false' do
      expect(array.my_all?(&:even?)).to eql(array.all?(&:even?))
    end
  end

  # my_all without block or args
  describe '#my_all?' do
    it 'my_all should return false' do
      expect([nil, true, 99].my_all?).to eq([nil, true, 99].all?)
    end
  end

  # my_all -- Class
  describe '#my_all?' do
    it 'my_all should return true' do
      expect(range.my_all?(Numeric)).to eql(range.all?(Numeric))
    end
  end

  # my_all -- Pattern
  describe '#my_all?' do
    it 'my_all should return false' do
      expect(%w[ant bear cat].my_all?(/t/)).to eql(%w[ant bear cat].all?(/t/))
    end
  end

  # my_map_with_block
  describe '#my_map' do
    it 'my_map should return the same as map' do
      expect(array.my_map { |element| element * 5 }).to eq(array.map { |element| element * 5 })
    end
  end

  # my_map_with_Proc
  describe '#my_map' do
    it 'my_map should return the same as map' do
      expect(array.my_map(&procc)).to eq(array.map(&procc))
    end
  end

  # my_inject
  describe '#my_inject' do
    it 'my_inject should return the same Total of a sum' do
      expect(array.my_inject { |total, element| total + element }).to eq(array.inject { |total, element| total + element})
    end
  end

  # my_inject  -- Block and initial value
  describe '#my_inject' do
    it 'my_inject should return the same Total of a multiplication' do
      expect((5..10).my_inject(1) { |product, n| product * n }).to eq((5..10).inject(1) { |product, n| product * n })
    end
  end

  # my_inject  --  Symbol
  describe '#my_inject' do
    it 'my_inject should return the same Total of a multiplication' do
      expect((5..10).my_inject(:*)).to eq((5..10).inject(:*))
    end
  end

  # my_inject  --  initial value and symbol
  describe '#my_inject' do
    it 'my_inject should return the same Total of a sum' do
      expect((5..10).my_inject(12, :+)).to eq((5..10).inject(12, :+))
    end
  end

  # my_count
  describe '#my_count' do
    it 'my_count should be equal to count' do
      expect(array.my_count).to eq(array.count)
    end
  end

  # my_count --arg
  describe '#my_count' do
    it 'my_count should be equal to count' do
      arr = [1, 2, 2, 2, 3]
      expect(arr.my_count(2)).to eq(arr.count(2))
    end
  end

  # my_count -- Block
  describe '#my_count' do
    it 'my_count should be equal to count' do
      expect(array.my_count(&:even?)).to eq(array.count(&:even?))
    end
  end
end
