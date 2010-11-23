require File.join(File.dirname(__FILE__), '..', 'stevenwilkin.com')

require 'rubygems'
require 'sinatra'
require 'rack/test'
require 'rspec'

# set test environment
set :environment, :test
set :run, false
set :raise_errors, true
set :logging, false

# Add an app method for RSpec
def app
  Sinatra::Application
end
