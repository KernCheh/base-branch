namespace :base_branch do
  desc 'Branch DB'
  task create_branch: :environment do
    puts 'Cloning DB for current branch'

    config = BaseBranch::Database::ActiveDatabase.branch_config

    new_branch = BaseBranch::Database::ActiveDatabase.create_branch_db
    config['branches'] << new_branch

    File.open(File.join(Rails.root, '.base_branch.yml'), 'w') do |f|
      f.write config.to_yaml
    end

    puts "New database: #{new_branch}"
  end
end
