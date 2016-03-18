class BaseBranch::GitBranch
  class << self
    def current_branch
      branches = `git branch -a`.split("\n")

      raise(
        BaseBranch::Exceptions::UninitializedRepository,
        'Please initialize a git repository and have at least one branch.'
      ) if branches.empty?

      (branches.detect { |br| br[0, 2] == '* ' } || '').gsub('* ', '').chomp
    end

    def master?
      current_branch == 'master'
    end
  end
end
