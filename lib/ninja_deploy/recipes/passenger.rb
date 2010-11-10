Capistrano::Configuration.instance(:must_exist).load do
  namespace :passenger do
    desc "Restart the passenger module to reload the application after deploying."
    task :restart, :roles => :app, :except => {:no_release => true} do
      run "touch #{current_path}/tmp/restart.txt"
    end

    desc "Restart the passenger module to reload the application after deploying using sudo."
    task :sudo_restart, :roles => :app, :except => {:no_release => true} do
      sudo "touch #{current_path}/tmp/restart.txt"
    end
  end
end