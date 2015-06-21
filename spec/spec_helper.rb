# encoding: utf-8
require "codeclimate-test-reporter"
CodeClimate::TestReporter.start
require 'rspec'
require 'naminori'
require 'support/lb'
require 'support/service'
require 'support/serf'

Dir["./support/**/*.rb"].each do |f|
  require f
end

RSpec.configure do |config|
end

