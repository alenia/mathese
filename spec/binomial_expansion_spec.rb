require 'binomial_expansion'
include BinomialExpansion

describe 'Binomial Expansion' do

  describe 'pascal' do
    it 'should work' do
      pascal(0).should == [1]
      pascal(1).should == [1,1]
      pascal(2).should == [1,2,1]
      pascal(3).should == [1,3,3,1]
      pascal(4).should == [1,4,6,4,1]
    end
  end
  describe 'binomial_expansion' do
    it 'should return an expanded array in which each element is sorted alphabetically' do
      binomial_expansion(1).should == ['a','b']
      binomial_expansion(2).should == ['aa','ab','ab','bb']
      binomial_expansion(3).should == ['aaa','aab','aab','aab','abb','abb','abb','bbb']
    end
  end
  describe 'expand' do
    it 'should work for arrays of length 1 for the second value' do
      expand(['a','b','c'],['e']).should == ['ae','be','ce']
    end

    it 'should work for arrays of length 1 for the first value' do
      expand(['a'],['b','c','d']).should == ['ab','ac','ad']
    end

    it 'should work for arrays of larger lengths' do
      expand(['a','b'],['a','b']).should == ['aa','ba','ab','bb']
      expand(['a','b','c'],['d','e','f']).should == ['ad','bd','cd','ae','be','ce','af','bf','cf']
    end
  end

  describe 'Array.exponentize' do
    it 'should return a hash based on the exponents' do
      ['a','b','b','c','c','c','c','d'].exponentize.should ==
        { 'a' => 1, 'b' => 2, 'c' => 4, 'd' => 1 }
    end
  end
end
