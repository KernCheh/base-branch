class BaseBranch::GitBranch
  class << self
    def current_branch
      exec('git branch -a')
    end

    def master?

    end
  end
end
