# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'ninja_deploy/version'

Gem::Specification.new do |s|
  s.name        = 'ninja-deploy'
  s.version     = NinjaDeploy::VERSION
  s.summary     = 'Common shared deployment recipes for your pleasure.'
  s.description = s.summary
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Jason Harrelson', 'Nils Jonsson']
  s.email       = %w(jason@lookforwardenterprises.com ninja-deploy@nilsjonsson.com)
  s.homepage    = 'http://github.com/ninja-loss/ninja-deploy'
  s.license     = 'MIT'

  # TODO: Claim the RubyForge project
  # s.rubyforge_project = 'ninja-deploy'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map do |f|
                      File.basename f
                    end
  s.require_paths = %w(lib)
  s.has_rdoc      = true

  s.add_runtime_dependency     'cape',  '~> 1'

  s.add_development_dependency 'rake',  '~> 0'
  s.add_development_dependency 'rspec', '~> 2'
end
