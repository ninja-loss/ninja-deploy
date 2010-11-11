Capistrano::Configuration.instance( :must_exist ).load do
  namespace :deploy do
    namespace :web do
      desc <<-DESC
        Present custom maintenance page to visitors. Disables your application's web \
        interface by writing a "maintenance.html" file to each web server. The \
        servers must be configured to detect the presence of this file, and if \
        it is present, always display it instead of performing the request.

        By default, the maintenance page will just say the site is down for \
        "maintenance", and will be back "shortly", but you can customize the \
        page by specifying the REASON and UNTIL environment variables:

          $ cap deploy:web:disable \\
                REASON="hardware upgrade" \\
                UNTIL="12pm Central Time"

        Further customization copy your html file to shared_path+'/system/maintenance.html.custom'.
        If this file exists it will be used instead of the default capistrano ugly page
      DESC
      task :disable, :roles => :web, :except => { :no_release => true } do
        maint_file = "#{shared_path}/system/maintenance.html"
        on_rollback { run "rm #{shared_path}/system/maintenance.html" }

        reason = ENV['REASON']
        deadline = ENV['UNTIL']

        template = File.read(File.join(File.dirname(__FILE__), "templates", "maintenance.html.erb"))
        #result = Haml::Engine.new(template).to_html
        result = ERB.new(template).result(binding)

        put result, "#{shared_path}/system/maintenance.html.tmp", :mode => 0644
        run "if [ -f #{shared_path}/system/maintenance.html.custom ]; then cp #{shared_path}/system/maintenance.html.custom #{maint_file}; else cp #{shared_path}/system/maintenance.html.tmp #{maint_file}; fi"
      end
    end
  end
end