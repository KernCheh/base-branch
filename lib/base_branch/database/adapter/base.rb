module BaseBranch::Database
  module Adapter
    class Base
      class << self
        def orm_execute(stmt)
          ActiveRecord::Base.connection.execute stmt
        end

        def orm_sanitize(field)
          ActiveRecord::Base.sanitize field
        end

        def orm_successfully_executed?(result)
          result.result_status == 1
        end
      end
    end
  end
end
