Capistrano::Configuration.instance( :must_exist ).load do
  namespace :rvm do
    desc 'Trust rvmrc file.'
    task :trust_rvmrc do
      run "rvm rvmrc trust #{current_release}"
    end
  end
end