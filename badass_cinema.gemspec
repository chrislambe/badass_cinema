# -*- encoding: utf-8 -*-
require File.expand_path("../lib/badass_cinema/version", __FILE__)

Gem::Specification.new do |gem|
  gem.name                = "badass_cinema"
  gem.version             = BadassCinema::VERSION
  gem.authors             = ["Chris Lambe"]
  gem.email               = ["chris@chrislambe.com"]
  gem.summary             = "A library for parsing various Alamo Drafthouse data sources."
  gem.description         = gem.summary
  gem.homepage            = "http://github.com/chrislambe/badass_cinema"

  gem.files               = `git ls-files`.split($\)
  gem.executables         = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files          = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths       = ["lib"]

  # Dependencies
  gem.add_dependency      "rake", "~> 10.0.3"
  gem.add_dependency      "chronic", "~> 0.9.0"
  gem.add_dependency      "colored", "~> 1.2"
end