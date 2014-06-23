require 'date'
require 'pony'

EMAIL_REGEX		= /\b[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}\b/ unless defined? EMAIL_REGEX
EMAIL_TO		= 'steve@stevenwilkin.com' unless defined? EMAIL_TO
EMAIL_SUBJECT	= '[Contact Form] stevenwilkin.com' unless defined? EMAIL_SUBJECT
EMAIL_FROM    = 'contact@stevenwilkin.com'

class StevenWilkinDotCom < Sinatra::Base
  
  set :static, true
  set :public, File.join(File.dirname(__FILE__), 'public')
  set :logging, true

  get '/' do
		@id_for_body = 'home'
		haml :index
	end
	
	get '/cv' do
		@id_for_body = 'cv'
		haml :cv
	end
	
	get '/projects' do
		@projects = [
			{
				:domain => 'stevenwilkin.com',
				:desc => 'This site, which is currently running on Sinatra',
				:git => 'http://github.com/stevenwilkin/stevenwilkin.com'
			},
			{
				:domain => 'life.stevenwilkin.com',
				:desc => 'An experimental lifestream app developed with Sinatra',
				:git => 'http://github.com/stevenwilkin/life.stevenwilkin.com'
			},
			{
				:domain => 'hugagoth.com',
				:desc => 'A novelty site created to help me learn Rails'
			},
			{
				:domain => 'hometi.me',
				:desc => 'Another novelty site, implemented with Sinatra and JavaScript, hosted on Heroku',
				:git => 'http://github.com/stevenwilkin/hometi.me'
			},
			{
				:domain => 'isitraininginbelfast.com',
				:desc => 'An experiment in Ruby, cron and screen-scraping',
				:git => 'http://github.com/stevenwilkin/isitraininginbelfast.com'
			},
			{
				:domain=> 'movies.stevenwilkin.com',
				:desc=> 'A small Rails app to manage my DVD collection',
				:git=> 'http://github.com/stevenwilkin/movies.stevenwilkin.com'
			},
			{
				:domain => 'io.gd',
				:desc => 'A trivial URL shortening service developed with Rails',
				:git => 'http://github.com/stevenwilkin/io.gd'
			},
			{
				:domain=> 'istrending.com',
				:desc=> 'A small Twitter/Google Images mashup powered by Sinatra',
				:git=> 'http://github.com/stevenwilkin/istrending.com'
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
		@name = params[:name] || ''
		@email = params[:email] || ''
		@message = params[:message] || ''
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
      body = ''
      params.each {|key, value| body += "#{key.capitalize}: #{value}\n"}
      Pony.mail(:to => EMAIL_TO, :subject => EMAIL_SUBJECT, :from => EMAIL_FROM,
        :body => body)
			haml :contact_thanks
		else
			haml :contact
		end
	end

end
