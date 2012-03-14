require 'cape'

module NinjaDeploy

  class << self
    %w( local remote ).each do |location|
      reader = "#{location}_rake_executable"
      writer = "#{reader}="
      [reader, writer].each do |method|
        define_method method do |*arguments, &block|
          Cape.send( method, *arguments, &block )
        end
      end
    end
  end

end

def NinjaDeploy( &block )
  Cape( &block )
end
