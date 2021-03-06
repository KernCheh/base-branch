require 'rails/generators/base'

module BaseBranch
  class InstallGenerator < Rails::Generators::Base
    class_option :default_db

    desc 'This generator creates an configuration file at config/base_branch.yml'
    def create_initializer_file
      db_name = options[:default_db]

      if !db_name || db_name.empty?
        say('What is the name of your default development database? (Leave blank if unchanged from database.yml)')
        db_name = ask('Database Name: ')
      end

      db_name = Rails.configuration.database_configuration['development']['database'] if db_name.empty?

      create_file 'config/base_branch.yml', <<-YAML
# This file is automatically generated from `rails g base_branch:initializer`

default_db: '#{db_name}'
      YAML

      database_yml = File.join(Rails.root, 'config', 'database.yml')
      database_config = YAML::load_file(database_yml)
      dev_database_name = database_config['development']['database']

      database_yml_lines = IO.readlines(database_yml)
      database_yml_lines = database_yml_lines
                             .map{|s| s.gsub(dev_database_name, "<%= defined?(BaseBranch) ? BaseBranch::Database::ActiveDatabase.database_name : '#{dev_database_name}' %>")}

      File.open(database_yml, 'w') do |file|
        file.puts database_yml_lines
        file.close
      end

      append_to_file '.gitignore', <<-FILE

# Do not check in base-branch files into SCM
.base_branch.yml
      FILE
    end
  end
end
