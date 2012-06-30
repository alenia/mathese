require 'basic_recursive_methods'

describe 'basic recursive methods' do
  include BasicRecursiveMethods

  describe "#fib(n)" do
    it "should return 0 if n = 0 and 1 if n = 1" do
      fib(0).should == 0
      fib(1).should == 1
    end
    it "should return fib(n-1) + fib(n-2) if n > 1" do
      20.times do |n|
        n += 2
        fib(n).should == fib(n-1) + fib(n-2)
      end
    end
  end

  describe 'factorial(n)' do
    it 'should work' do
      factorial(0).should == 0
      factorial(1).should == 1
      factorial(2).should == 2
      factorial(3).should == 6
      factorial(4).should == 24
    end
  end
end
