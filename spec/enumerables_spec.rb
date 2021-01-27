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
    it 'return false'
      expect(array.my_any?(Numeric)).to eq(array.any?(Numeric))
    end
  end
end
