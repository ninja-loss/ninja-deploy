Capistrano::Configuration.instance( :must_exist ).load do
  namespace :version do
    desc 'Writes a VERSION file to the public directory of the application'
    task :write do
      run "echo #{branch_tag_or_sha_to_deploy} > #{release_path}/public/VERSION"
    end
  end
end