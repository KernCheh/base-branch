require 'base_branch/version'

module BaseBranch
end

require 'base_branch/git_branch'
require 'base_branch/exceptions/uninitialized_repository'

require 'base_branch/railtie' if defined?(Rails)
