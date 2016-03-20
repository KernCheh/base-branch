$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'base-branch'

require 'minitest/autorun'
require 'rr'
require 'rails/generators/test_case'
require 'generators/base_branch/install_generator'

class Minitest::Test
  include RR::Adapters::RRMethods
end
