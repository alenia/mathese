require 'basic_recursive_methods'
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
