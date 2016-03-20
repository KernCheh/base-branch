require 'test_helper'

class GitBranchTest < Minitest::Test
  def test_current_branch
    stub(BaseBranch::GitBranch).branches { ['  branch2', '* master', '  remotes/origin/master'] }
    assert_equal 'master', BaseBranch::GitBranch.current_branch

    stub(BaseBranch::GitBranch).branches { ['* branch2', '  master', '  remotes/origin/master'] }
    assert_equal 'branch2', BaseBranch::GitBranch.current_branch
  end
end
