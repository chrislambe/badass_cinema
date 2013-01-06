require "bundler"
Bundler.setup

require "rspec/core/rake_task"
RSpec::Core::RakeTask.new(:spec)

gemspec = eval(File.read("badass_cinema.gemspec"))

task :build => "#{gemspec.full_name}.gem"

file "#{gemspec.full_name}.gem" => gemspec.files + ["badass_cinema.gemspec"] do
  system "gem build badass_cinema.gemspec"
  system "gem install badass_cinema-#{BadassCinema::VERSION}.gem"
end