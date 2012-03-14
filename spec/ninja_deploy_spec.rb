require 'ninja_deploy'

describe NinjaDeploy do
  %w( local_rake_executable remote_rake_executable ).each do |attribute|
    describe ".#{attribute}" do
      it "should return the value of Cape.#{attribute}" do
        Cape.stub!( attribute.to_sym ).and_return 'expected value'
        NinjaDeploy.send( attribute ).should == 'expected value'
      end

      it "should set the value of Cape.#{attribute}" do
        NinjaDeploy.send "#{attribute}=", 'passed-through value'
        Cape.send( attribute ).should == 'passed-through value'
      end
    end
  end
end

describe '#NinjaDeploy' do
  it 'should yield the Cape module if given a unary block' do
    yielded = nil
    NinjaDeploy do |object|
      yielded = object
    end
    yielded.name.should == 'Cape'
  end

  it 'should accept a nullary block' do
    NinjaDeploy do
    end
  end
end
