Capistrano::Configuration.instance( :must_exist ).load do
  namespace :thinking_sphinx do
    desc "Stops thinking sphinx using the config file in the previous release (as there is not one configured in this release yet)."
    task :stop_using_previous_config do
      run "cd #{previous_release} && bundle exec rake RAILS_ENV=#{rails_env} thinking_sphinx:stop"
    end

    desc "Stop and then start the Sphinx daemon"
    task :restart do
      stop
      start
    end

    desc "Add the shared folder for sphinx files for the production environment"
    task :shared_sphinx_folder, :roles => :web do
      run "mkdir -p #{shared_path}/db/sphinx/#{rails_env}"
    end

    desc "Symlink to the shared folder for sphinx files for the production environment"
    task :symlink_sphinx_indexes, :roles => [:app] do
      run "ln -nfs #{shared_path}/db/sphinx #{release_path}/db/sphinx"
    end

    def rake(*tasks)
      rails_env = fetch(:rails_env, "production")
      rake = fetch(:rake, "rake")
      tasks.each do |t|
        run "if [ -d #{release_path} ]; then cd #{release_path}; else cd #{current_path}; fi; #{rake} RAILS_ENV=#{rails_env} #{t}"
      end
    end
  end
end