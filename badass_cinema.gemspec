require File.expand_path("../lib/badass_cinema/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = "badass_cinema"
  s.version     = BadassCinema::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Chris Lambe"]
  s.email       = ["chris@chrislambe.com"]
  s.homepage    = "http://github.com/chrislambe/badass_cinema"
  s.summary     = "A library for parsing various Alamo Drafthouse data sources."
  s.description = s.summary

  s.rubyforge_project         = "badass_cinema"

  s.files        = Dir["{lib}/**/*.rb", "bin/*", "LICENSE", "*.md"]
  s.require_path = 'lib'
end