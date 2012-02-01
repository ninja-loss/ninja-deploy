require 'ninja_deploy'

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
