Capistrano::Configuration.instance( :must_exist ).load do
  namespace :whenever do
    desc "Update the crontab file using whenever"
    task :update_crontab, :roles => :db do
      run "cd #{release_path} && bundle exec whenever --set environment=#{rails_env} --update-crontab #{application}"
    end
  end
end