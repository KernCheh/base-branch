require 'yaml'
require 'active_support/inflector'

module BaseBranch::Database
  class ActiveDatabase
    class << self
      def database_name
        branch_specific_db || default_db_name
      end

      def branch_specific_db
        db_name = branch_specific_db_name
        db_present?(db_name) ? db_name : nil
      end

      def default_db_name
        @default_db_name ||= begin
          YAML::load_file(File.join(Rails.root, 'config', 'base_branch.yml'))['default_db']
        rescue Errno::ENOENT => e
          raise BaseBranch::Exceptions::DefaultDatabaseUnset, 'Please run `rails g base_branch:install` first'
        end
      end

      def branch_specific_db_name
        current_branch = BaseBranch::GitBranch.current_branch
        unless current_branch == 'master'
           "#{default_db_name}-#{current_branch}"
        end
      end

      def db_present?(db_name)

      end

      def current
        Rails.configuration.database_configuration['development']['database']
      end

      def adapter
        "BaseBranch::Database::Adapter::#{Rails.configuration.database_configuration['development']['adapter'].classify}"
          .constantize
      end
    end

    private_class_method :db_present?, :current, :adapter
  end
end
