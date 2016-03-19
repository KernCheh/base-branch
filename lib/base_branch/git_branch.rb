class BaseBranch::GitBranch
  class << self
    def current_branch
      raise(
        BaseBranch::Exceptions::UninitializedRepository,
        'Please initialize a git repository and have at least one branch.'
      ) if (branchez = branches).empty?

      (branchez.detect { |br| br[0, 2] == '* ' } || '').gsub('* ', '').chomp
    end

    def master?
      current_branch == 'master'
    end

    def branches
      `git branch -a`.split("\n")
    end
  end

  private_class_method :branches
end
