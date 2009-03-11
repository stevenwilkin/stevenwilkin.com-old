require 'rubygems'
require 'sinatra'

# we're using Passenger do don't start Mongrel
disable :run

# enable production logging
set :raise_errors, true
log = File.new("log/sinatra.log", "a")
STDOUT.reopen(log)
STDERR.reopen(log)

require 'stevenwilkin.com.rb'
run Sinatra::Application
