module BaseBranch
  class Railtie < Rails::Railtie
    railtie_name :base_branch

    initializer 'Base Branch initializer' do
      ActiveSupport.on_load(:action_controller) do
        include BaseBranch
      end
    end

    generators do
      require_relative '../generators/base_branch/install_generator'
    end
  end
end
