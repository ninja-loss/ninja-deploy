Capistrano::Configuration.instance( :must_exist ).load do
  namespace :log do
    task :tail, :roles => :app do
      invoke_command "tail -f #{shared_path}/log/#{rails_env}.log"
    end
  end
end