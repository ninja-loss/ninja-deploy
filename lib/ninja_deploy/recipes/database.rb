Capistrano::Configuration.instance( :must_exist ).load do

  namespace :db do

    namespace :dump do

      desc 'Dump a remote database, fetch the dump file to local and then load it to the development database'
      task :to_local_db, :roles => :db, :only => { :primary => true } do
        local_file_full_path = dump_database_to_local

        puts "*** Reading local database config..."
        username, password, database, host = database_config( 'development' )

        puts "*** Loading data to local #{database} database"
        system "bzip2 -d -c #{local_file_full_path} | mysql -u #{username} --password='#{password}' #{database}"

        puts "*** Removing local dump file..."
        system "rm #{local_file_full_path}"
      end

      desc 'Dump a remote database and fetch the dump file to local /tmp directory'
      task :to_local_file, :roles => :db, :only => { :primary => true } do
        local_file_full_path = dump_database_to_local
        puts "*** You can find the dump file at: #{local_file_full_path}"
      end

      desc "Dump a remote database, fetch the dump file to the staging server and then load it to the staging database"
      task :to_staging_db, :roles => :db, :only => { :primary => true } do
        staging_file_full_path = dump_database_to_staging

        puts "*** Reading staging database config..."
        username, password, database, host = host_database_config( staging_host, 'deployer', 'staging' )

        Net::SSH.start( staging_host, 'deployer' ) do |ssh|
          puts "*** Loading data to staging #{database} database"
          ssh.exec! "bzip2 -d -c #{staging_file_full_path} | mysql -h #{host} -u #{username} --password='#{password}' #{database}"

          puts "*** Removing staging dump file..."
          ssh.exec! "rm #{staging_file_full_path}"
        end
      end

    end # namespace :dump

    def dump_database_to_local
      prepare_for_database_dump

      puts "*** Reading database credentials... "
      user, password, database, host = remote_database_config( rails_env )

      dump_database( password )

      local_file_full_path = "/tmp/#{File.basename dump_file_bz2_full_path}"
      puts "*** Fetching the dump file from '#{dump_file_bz2_full_path}' and putting it at '#{local_file_full_path}'..."
      get dump_file_bz2_full_path, local_file_full_path

      remove_dump_file

      local_file_full_path
    end

    def dump_database_to_staging
      prepare_for_database_dump

      puts "*** Reading database credentials... "
      user, password, database, host = remote_database_config( rails_env )

      dump_database( password )

      staging_file_full_path = "/tmp/#{File.basename dump_file_bz2_full_path}"

      puts "*** Fetching the dump file from '#{environment_host}:#{dump_file_bz2_full_path}' and putting it at '#{staging_host}:#{staging_file_full_path}'..."

      scp_cmd = "scp #{environment_host}:#{dump_file_bz2_full_path} #{staging_file_full_path}"
      puts "*** Executing: #{scp_cmd}"

      Net::SSH.start( staging_host, 'deployer' ) do |ssh|
        ssh.exec! scp_cmd
      end

      remove_dump_file

      staging_file_full_path
    end

    def prepare_for_database_dump
      now = Time.now
      run "mkdir -p #{shared_path}/db_backups"
      dump_time = [now.year, now.month, now.day, now.hour, now.min, now.sec].join( '' )
      set :dump_file, "#{environment_database}-dump-#{dump_time}.dmp"
      set :dump_file_path, "#{shared_path}/db_backups"
      set :dump_file_full_path, "#{dump_file_path}/#{dump_file}"
      set :dump_file_bz2_full_path, "#{dump_file_full_path}.bz2"
    end

    def dump_database( password )
      puts "*** Dumping #{environment_database} database..."
      run dump_database_cmd( password )
    end

    def dump_database_cmd( password )
      "mysqldump --add-drop-table -u #{environment_db_user} -h #{environment_db_host.gsub('-master', '-replica')} -p#{password} #{environment_database} #{tables_to_dump} | bzip2 -c > #{dump_file_bz2_full_path}"
    end

    def tables_to_dump
      require 'rubygems'
      require 'active_record'
      except = ENV['EXCEPT']
      except = except.nil? ? nil : Array( except.split( ',' ) )
      ActiveRecord::Base.establish_connection( local_database_config_hash['development'] )

      except.nil? ?
        nil :
        (ActiveRecord::Base.connection.tables - except).join( ' ' )
    end

    def remove_dump_file
      puts "*** Removing the dump file from the server..."
      run "rm #{dump_file_bz2_full_path}"
    end

    def local_database_config_hash
      YAML::load_file( 'config/database.yml' )
    end

    # Reads the database credentials from the local config/database.yml file
    # +db+ the name of the environment to get the credentials for
    # Returns username, password, database
    #
    def database_config( db )
      database = local_database_config_hash
      return database["#{db}"]['username'], database["#{db}"]['password'], database["#{db}"]['database'], database["#{db}"]['host']
    end

    # Reads the database credentials from the remote config/database.yml file
    # +db+ the name of the environment to get the credentials for
    # Returns username, password, database
    #
    def remote_database_config( db )
      remote_config = capture("cat #{shared_path}/config/database.yml")
      database = YAML::load( remote_config )
      return database["#{db}"]['username'], database["#{db}"]['password'], database["#{db}"]['database'], database["#{db}"]['host']
    end

    def host_database_config( host, user, db )
      remote_config = nil

      Net::SSH.start( host, user ) do |ssh|
        remote_config = ssh.exec!( "cat #{shared_path}/config/database.yml" )
      end

      database = YAML::load( remote_config )

      return database["#{db}"]['username'], database["#{db}"]['password'], database["#{db}"]['database'], database["#{db}"]['host']
    end

  end

end
