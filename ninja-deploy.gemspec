# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{ninja-deploy}
  s.version = "1.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Ninja Loss"]
  s.date = %q{2011-04-07}
  s.description = %q{Common shared deployment recipes for your pleasure.}
  s.email = %q{ninja.loss@gmail.com}
  s.extra_rdoc_files = [
    "LICENSE",
    "README.rdoc"
  ]
  s.files = [
    ".document",
    ".rvmrc",
    "LICENSE",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "lib/ninja_deploy.rb",
    "lib/ninja_deploy/recipes/database.rb",
    "lib/ninja_deploy/recipes/deploy.rb",
    "lib/ninja_deploy/recipes/log.rb",
    "lib/ninja_deploy/recipes/passenger.rb",
    "lib/ninja_deploy/recipes/rvm.rb",
    "lib/ninja_deploy/recipes/sass.rb",
    "lib/ninja_deploy/recipes/thinking_sphinx.rb",
    "lib/ninja_deploy/recipes/version.rb",
    "lib/ninja_deploy/recipes/whenever.rb",
    "ninja-deploy.gemspec",
    "spec/ninja-deploy_spec.rb",
    "spec/spec.opts",
    "spec/spec_helper.rb"
  ]
  s.homepage = %q{http://github.com/ninja-loss/ninja-deploy}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.7.2}
  s.summary = %q{Common shared deployment recipes.}
  s.test_files = [
    "spec/ninja-deploy_spec.rb",
    "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, [">= 1.2.9"])
      s.add_development_dependency(%q<yard>, [">= 0"])
    else
      s.add_dependency(%q<rspec>, [">= 1.2.9"])
      s.add_dependency(%q<yard>, [">= 0"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 1.2.9"])
    s.add_dependency(%q<yard>, [">= 0"])
  end
end

