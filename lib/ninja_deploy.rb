require 'cape'

module NinjaDeploy
  VERSION = File.read( "#{File.dirname __FILE__}/../VERSION" ).chomp
end

def NinjaDeploy( &block )
  Cape( &block )
end
