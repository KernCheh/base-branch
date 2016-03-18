module BaseBranch
  class Railtie < Rails::Railtie
    initializer 'Base Branch initializer' do
      ActiveSupport.on_load(:action_controller) do
        include BaseBranch
      end
    end
  end
end
