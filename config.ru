require 'rubygems'
require 'sinatra'

# middleware
require 'lib/no_www'
require 'lib/redirect_to_tld'
use NoWWW
use RedirectToTLD, 'stevenwilkin.com'

require 'stevenwilkin.com.rb'
run StevenWilkinDotCom
