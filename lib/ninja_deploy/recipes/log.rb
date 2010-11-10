Capistrano::Configuration.instance( :must_exist ).load do
  namespace :log do
    desc "Tail a log on the remote server"
    task :tail, :roles => :app do
      invoke_command "tail -f #{shared_path}/log/#{rails_env}.log"
    end
  end
end