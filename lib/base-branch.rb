require 'base_branch/version'

module BaseBranch
end

require 'base_branch/git_branch'
require 'base_branch/exceptions/default_database_unset'
require 'base_branch/exceptions/uninitialized_repository'
require 'base_branch/database/active_database'
require 'base_branch/database/adapter/base'
require 'base_branch/database/adapter/postgresql'

# Railtie
require 'base_branch/railtie' if defined?(Rails)
