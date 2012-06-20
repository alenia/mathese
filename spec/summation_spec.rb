require 'summation'

describe 'lemma/spike' do
  describe 'looping' do
    let(:ev_proc) { proc{ |a, b| 2*a + 3*b } }
    let(:sum1) { proc{ |k| proc{0}.curry[k] + ev_proc.curry[1, k] } }
    let(:sum2) { proc{ |k| sum1.curry[k] + ev_proc.curry[2,k] } }
    let(:sum3) { proc{ |k| sum2.curry[k] + ev_proc.curry[3,k] } }

    it 'should eval sum1' do
      sum1.call(0).should == 0 + 2*1 + 3*0
      sum1.call(1).should == 0 + 2*1 + 3*1
      sum1.call(2).should == 0 + 2*1 + 3*2
    end

    it 'should eval sum2' do
      sum2.call(0).should == 0 + (2*1 + 3*0) + (2*2 + 3*0)
      sum2.call(1).should == 0 + (2*1 + 3*1) + (2*2 + 3*1)
      sum2.call(2).should == 0 + (2*1 + 3*2) + (2*2 + 3*2)
    end

    it 'should eval sum3' do
      sum3.call(0).should == 0 + (2*1 + 3*0) + (2*2 + 3*0) + (2*3 + 3*0)
      sum3.call(1).should == 0 + (2*1 + 3*1) + (2*2 + 3*1) + (2*3 + 3*1)
      sum3.call(2).should == 0 + (2*1 + 3*2) + (2*2 + 3*2) + (2*3 + 3*2)
    end
  end

  describe 'proc of procs' do
    let(:thing) { proc{|k| (proc{|i| 2*i}).curry[k] +(proc{|i| 3*i}).curry[1, k]} }

    it 'should turn into a number' do
      thing.curry[1].should == 2 + 3
      proc{thing.curry[1]}.curry[].should == 2 + 3
    end
  end
end

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
      end

      it 'evaluate should return an integer that is the result of the sum' do
        subject.evaluate.should == 5
      end
    end

    context 'when the expression passed in is a proc with multiple arguments' do
      let(:expression) { proc { |a,b| a + b } }

      it 'should set the expression to the passed in proc' do
        subject.expression.should == expression
      end

      # TODO: assertain that the parameter is correct.
      describe 'evaluate' do
        subject{ Summation.new(low, high, expression).evaluate }

        it 'should return a proc with the correct arguments' do
          subject.class.should == Proc
          subject.parameters.length.should == 1
          #subject.parameters[0][1].should == :b
        end
        it 'should be the result of the expression' do
          subject.call(0).should == 15
          subject.call(1).should == 20
        end
      end
    end
  end
end
