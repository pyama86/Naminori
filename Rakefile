require "bundler/gem_tasks"
require "rspec/core/rake_task"
ENV['CODECLIMATE_REPO_TOKEN'] = "47135cdaac4078905036e9ec2506567cd244bd711794ed292b8f36fee6fa1f22"
ENV['PEC_TEST'] = "test"
RSpec::Core::RakeTask.new("spec")
task :default => :spec
