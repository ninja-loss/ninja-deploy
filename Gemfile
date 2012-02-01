source 'http://rubygems.org'

gemspec

group :debug do
  gem   'ruby-debug',   '~> 0', :platforms => :mri_18
  gem   'ruby-debug19', '~> 0', :platforms => :mri_19, :require => 'ruby-debug'
end

group :doc do
  gem   'yard',         '~> 0', :platforms => [:ruby, :mswin, :mingw]
  gem   'rdiscount',    '~> 1', :platforms => [:ruby, :mswin, :mingw]
end

group :tooling do
  gem   'guard-rspec',  '~> 0'
  if RUBY_PLATFORM =~ /darwin/i
    gem 'rb-fsevent',   '~> 0',                        :require => false
  end
end
