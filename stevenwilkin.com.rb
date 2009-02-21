#!/usr/bin/env ruby

require 'rubygems'
require 'sinatra'
require 'haml'

get '/' do
	haml :index
end

get '/projects' do
	haml :projects
end
