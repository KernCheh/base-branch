# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'base_branch/version'

Gem::Specification.new do |spec|
  spec.name          = 'base-branch'
  spec.version       = BaseBranch::VERSION
  spec.authors       = ['Sim Kern Cheh']
  spec.email         = ['kern.cheh@gmail.com']

  spec.summary       = %q{Create and clone databases easily for your feature branches in Rails projects.}
  spec.description   = %q{Create and clone databases easily for your feature branches in Rails projects.}
  spec.homepage      = "TODO: Put your gem's website or public repo URL here."
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'rails', '>= 4.2'
  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest', '~> 5.0'

  spec.add_development_dependency 'rr', '~> 1.1'
end
