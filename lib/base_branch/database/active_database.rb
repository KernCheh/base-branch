require 'yaml'
require 'active_support/inflector'

module BaseBranch::Database
  class ActiveDatabase
    class << self
      def database_name
        branch_specific_db || default_db_name
      end

      def default_db_name
        @_default_db_name ||= begin
          YAML::load_file(File.join(Rails.root, 'config', 'base_branch.yml'))['default_db']
        rescue Errno::ENOENT => e
          warn 'Please run `rails g base_branch:install`'
          nil
        end
      end

      def branch_specific_db
        db_name = branch_specific_db_name
        branch_db_present?(db_name) ? db_name : nil
      end

      def branch_specific_db_name
        current_branch = BaseBranch::GitBranch.current_branch

        unless current_branch == 'master'
           "#{default_db_name}-#{current_branch.gsub('/', '_')}"
        end
      end

      def create_branch_db
        unless branch_specific_db
          new_db_name = branch_specific_db_name
          adapter.clone_db new_db_name, default_db_name, db_user
        end

        new_db_name
      end

      def branch_config
        @_branch_config ||= begin
          if File.exists?(File.join(Rails.root, '.base_branch.yml'))
            YAML::load_file(File.join(Rails.root, '.base_branch.yml'))
          else
            {
              'branches' => []
            }
          end
        end
      end

      def branch_db_present?(db_name)
        return nil unless db_name

        branch_config['branches'].include?(db_name)
      end

      def current
        rails_db_config['development']['database']
      end

      def adapter
        "BaseBranch::Database::Adapter::#{rails_db_config['development']['adapter'].classify}"
          .constantize
      end

      def db_user
        rails_db_config['development']['username']
      end

      def rails_db_config
        Rails.configuration.database_configuration
      end
    end

    private_class_method :branch_db_present?, :current, :adapter, :db_user, :rails_db_config
  end
end
