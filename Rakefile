require 'bundler/setup'
Bundler.setup()
require "rspec/core/rake_task"

namespace :test do
  Bundler.setup(:test)

  desc "Do all tests <- Default"
  task :all => [:story_one, :story_two]

  desc "Do the Story One tests"
  RSpec::Core::RakeTask.new(:story_one) do |t|
    t.pattern = [File.join("spec", "spec_helper.rb"), File.join("spec", "spec_story_one.rb")]
  end

  desc "Do the Story Two tests"
  RSpec::Core::RakeTask.new(:story_two) do |t|
    t.pattern = [File.join("spec", "spec_helper.rb"), File.join("spec", "spec_story_two.rb")]
  end

end

task :default => "test:all"