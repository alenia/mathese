require 'summation'

describe Summation do
  subject do
    Summation.new(low, high, expression)
  end

  context 'when integers are passed in for low and high' do
    let(:low) { 1 }
    let(:high) { 5 }
    let(:expression) { ->(i) {i} }

    it 'should evaluate the expression' do
      subject.evaluate.should == 15
    end

    describe 'to_latex' do
      it 'should include the low and high values and the parameter from the proc' do
        subject.to_latex.should match /^\$\\sum_{i=1}\^5 /
      end

      it 'should include the declared expression' do
        pending
        subject.to_latex.should match /\si\$$/
      end
    end
  end
end
