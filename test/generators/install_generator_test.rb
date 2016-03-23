require 'test_helper'

class InstallGeneratorTest < Rails::Generators::TestCase
  tests BaseBranch::InstallGenerator
  destination File.expand_path('../../tmp', __FILE__)

  setup :prepare_destination

  def setup
    @path = File.expand_path('../../tmp', __FILE__)
    FileUtils.touch(File.join(@path, '.gitignore'))
    FileUtils.mkdir_p(File.join(@path, 'config'))

    File.open(File.join(@path, 'config', 'database.yml'), 'w') do |file|
      file.write({'development' => {'database' => 'test-db'}}.to_yaml)
    end

    super
  end

  test 'properly creates base_branch.yml' do
    stub(Rails).root {@path}

    run_generator(['--default_db=default'])
    assert_file 'config/base_branch.yml'
    assert_file '.gitignore', %r{.base_branch.yml}
  end
end
