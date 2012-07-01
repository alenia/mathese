require 'summation'

describe Summation do
  subject do
    Summation.new(low, high, expression)
  end

  context 'when integers are passed in for low and high' do
    let(:low) { 1 }
    let(:high) { 5 }

    context 'if the passed in expression is a proc with one argument' do
      let(:expression) { proc { |i| i } }

      it 'should set the expression to the passed in proc' do
        subject.expression.should == expression
      end

      it 'should set the high value to a proc with one argument' do
        subject.high.class.should == Proc
        subject.high.parameters.length.should == 1
        subject.high.call.should == 5
      end

      it 'evaluate should return an integer that is the result of the sum' do
        subject.evaluate.should == 15
      end
    end

    context 'when the expression passed in is an integer' do
      let(:expression) { 1 }

      it 'should set the expression to a proc with one argument' do
        subject.expression.class.should == Proc
        subject.expression.parameters.length.should == 1
        subject.expression.parameters[0][1].should == :i
        subject.expression.call.should == 1
      end

      it 'evaluate should return an integer that is the result of the sum' do
        subject.evaluate.should == 5
      end
    end

    context 'when the expression passed in is a proc with multiple arguments' do
      let(:expression) { proc { |a,b| 2*a + 3*b } }

      it 'should set the expression to the passed in proc' do
        subject.expression.should == expression
      end

      describe 'evaluate' do
        subject{ Summation.new(low, high, expression).evaluate }

        it 'should return a proc with the correct arguments' do
          subject.class.should == Proc
          subject.parameters.length.should == 1
        end
        it 'should be the result of the expression' do
          subject.call(0).should == 30
          subject.call(1).should == 45
        end
      end
    end
  end

  context 'when a proc is passed in for high' do
    let(:low) { 1 }
    let(:high) { proc { |x| x } }

    context 'when an integer is passed in for the expression' do
      let(:expression) { 5 }
      it 'should return a proc that evaluates to the result of the sum for a passed in argument' do
        subject.evaluate.call(1).should == 5
        subject.evaluate.call(4).should == 20
        subject.evaluate.call(10).should == 50
      end
    end
  end

  context 'sums of sums' do
    let(:inner_sum){ Summation.new(1,5,proc{|a,b| 2*a + 3*b}).evaluate }
    let(:outer_sum){ Summation.new(3,6,inner_sum) }

    it 'should evaluate properly' do
      outer_sum.evaluate.should == inner_sum.call(3)+inner_sum.call(4)+inner_sum.call(5)+inner_sum.call(6)
      outer_sum.evaluate.should == 75 + 90 + 105 + 120
    end
  end
end
