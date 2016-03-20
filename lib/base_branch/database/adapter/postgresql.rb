module BaseBranch::Database::Adapter
  class Postgresql < Base
    class << self
      def clone_db(db_name, from_db, db_user)
        result = orm_execute <<-SQL
          CREATE DATABASE "#{db_name}" WITH TEMPLATE "#{from_db}" OWNER "#{db_user}";
        SQL

        orm_successfully_executed? result
      end

      def db_present?(db_name)
        field_name = orm_sanitize db_name
        result = orm_execute <<-SQL
          SELECT 1 from pg_database WHERE datname=#{field_name};
        SQL

        result.count > 0
      end
    end
  end
end
