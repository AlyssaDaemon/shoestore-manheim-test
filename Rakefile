require 'bundler/setup'
Bundler.setup()
require "rspec/core/rake_task"

namespace :test do
  Bundler.setup(:test)

  desc "Do all tests <- Default"
  RSpec::Core::RakeTask.new(:all) do |t|
    t.pattern = Dir.glob(File.join("spec", "**/spec*.rb"))
  end

  desc "Do the Story One tests"
  RSpec::Core::RakeTask.new(:story_one) do |t|
    t.pattern = [File.join("spec", "spec_helper.rb"), File.join("spec", "spec_shoe_page.rb"), File.join("spec", "spec_month_page.rb")]
  end

  desc "Do the Story Two tests"
  RSpec::Core::RakeTask.new(:story_two) do |t|
    t.pattern = [File.join("spec", "spec_helper.rb"), File.join("spec", "spec_email_submit.rb")]
  end

end

task :default => "test:all"