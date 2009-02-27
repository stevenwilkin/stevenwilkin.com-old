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
	@projects = [
		{
			:domain => 'stevenwilkin.com',
			:desc => 'This site, which is currently running on Sinatra',
			:git => 'http://github.com/stevenwilkin/stevenwilkin.com'
		},
		{
			:domain => 'hugagoth.com',
			:desc => 'A novelty site created to help me learn Rails'
		},
		{
			:domain => 'hometi.me',
			:desc => 'Another novelty site, running on CakePHP and making heavy use of AJAX'
		},
		{
			:domain => 'isitraininginbelfast.com',
			:desc => 'An experiment in Ruby, CRON and screen-scraping',
			:git => 'http://github.com/stevenwilkin/isitraininginbelfast.com'
		}
	]
	@id_for_body = 'projects'
	haml :projects
end

get '/contact' do
	@id_for_body = 'contact'
	haml :contact
end

post '/contact' do
	@id_for_body = 'contact'
	@info = params[:name]
	params.each{|param, value| eval "@#{param} = '#{value}'"}
	haml :contact
end
