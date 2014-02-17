require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

task :console do
  require "irb"
  require "irb/completion"
  require "verbalizeit"
  ARGV.clear
  IRB.start
end
