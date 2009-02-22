#!/usr/bin/env ruby

require 'rubygems'
require 'sinatra'
require 'haml'

get '/' do
	def age
		dob = Date::civil(1980, 1, 3)
		age = Date.today.year - dob.year
		age -= (Date.today < Date::civil(Date.today.year, dob.month, dob.day)) ? 1 : 0
	end
	@id_for_body = 'home'
	@age = age
	haml :index
end

get '/projects' do
	@id_for_body = 'projects'
	haml :projects
end
