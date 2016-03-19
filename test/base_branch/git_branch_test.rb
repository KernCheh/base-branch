require 'test_helper'

class GitBranchTest < Minitest::Test
  def test_current_branch
    BaseBranch::GitBranch.stub :branches, ['  branch2', '* master', '  remotes/origin/master'] do
      assert_equal 'master', BaseBranch::GitBranch.current_branch
    end
  end
end
