# -*- encoding: utf-8 -*-
require File.expand_path('../lib/wasserstand/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Nicholas E. Rabenau"]
  gem.email         = ["nerab@gmx.net"]
  gem.description   = %q{Unofficial Ruby wrapper for Pegel Online}
  gem.summary       = %q{Wasserstand auf deutschen Flüssen}
  gem.homepage      = "http://github.com/nerab/wasserstand"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "wasserstand"
  gem.require_paths = ["lib"]
  gem.version       = Wasserstand::VERSION

  gem.add_runtime_dependency 'require_all'
  gem.add_development_dependency 'minitest'
  gem.add_development_dependency 'rake'
end
