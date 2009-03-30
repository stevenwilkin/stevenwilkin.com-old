#!/usr/bin/env ruby

require 'rubygems'
require 'sinatra'
require 'haml'

EMAIL_REGEX		||= /\b[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}\b/
EMAIL_TO		||= 'steve@stevenwilkin.com'
EMAIL_SUBJECT	||= '[Contact Form] stevenwilkin.com'

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
			:desc => 'An experiment in Ruby, cron and screen-scraping',
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
	@name = params[:name]
	@email = params[:email]
	@message = params[:message]
	# form validation - required fields
	@info = nil
	['message', 'email', 'name'].each do |field_name|
		field = eval("@#{field_name}")
		if field.strip.empty?
			@info = "Please enter your #{field_name.capitalize}"
		end
	end
	# valid email address? all fields must already be present
	@info = 'Please enter a valid Email' if @info.nil? && @email !~ EMAIL_REGEX
	if @info.nil?
		# build the mailx syntax
		mailx = 'echo "'
		params.each {|key, value| mailx += "#{key.capitalize}: #{value}\n"}
		mailx += "\"| mailx -s '#{EMAIL_SUBJECT}' #{EMAIL_TO} "
		# send the mail
		system mailx
		haml :contact_thanks
	else
		haml :contact
	end
end
