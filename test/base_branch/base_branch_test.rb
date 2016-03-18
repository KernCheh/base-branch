require 'test_helper'

class BaseBranchTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::BaseBranch::VERSION
  end
end
