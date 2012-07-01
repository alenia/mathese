describe 'figuring out sums' do
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

