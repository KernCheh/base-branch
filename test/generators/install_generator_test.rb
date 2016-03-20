require 'test_helper'

class InstallGeneratorTest < Rails::Generators::TestCase
  tests BaseBranch::InstallGenerator
  destination File.expand_path('../../tmp', __FILE__)

  setup :prepare_destination
  teardown :cleanup_destination_root

  test 'properly creates base_branch.yml' do
    run_generator(['--default_db=default'])
    assert_file 'config/base_branch.yml'
  end
end
