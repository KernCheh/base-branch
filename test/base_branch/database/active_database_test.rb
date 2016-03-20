require 'test_helper'

class ActiveDatabaseTest < Minitest::Test
  def subject
    BaseBranch::Database::ActiveDatabase
  end

  def test_current
    stub(Rails).configuration.stub!.database_configuration do
      {
        'development' => {
          'database' => 'default-dev'
        }
      }
    end

    assert_equal 'default-dev', subject.send(:current)
  end

  def test_branch_specific_db_non_master
    stub(subject).db_present?.with_any_args { true }
    stub(subject).default_db_name { 'my-project' }
    stub(BaseBranch::GitBranch).current_branch { 'branch1' }

    assert_equal 'my-project-branch1', subject.branch_specific_db
  end

  def test_branch_specific_db_master
    stub(subject).db_present?.with_any_args { true }
    stub(subject).default_db_name { 'my-project' }
    stub(BaseBranch::GitBranch).current_branch { 'master' }

    refute subject.branch_specific_db
  end

  def test_branch_specific_db_branch_db_not_present
    stub(subject).db_present?.with_any_args { false }
    stub(subject).default_db_name { 'my-project' }
    stub(BaseBranch::GitBranch).current_branch { 'branch1' }

    refute subject.branch_specific_db
  end

  def test_adapter
    stub(Rails).configuration.stub!.database_configuration do
      {
        'development' => {
          'adapter' => 'postgresql'
        }
      }
    end

    assert_equal BaseBranch::Database::Adapter::Postgresql, subject.send(:adapter)
  end
end
