require 'rubygems'
require 'sinatra'

# middleware
$:.unshift File.join(File.dirname(__FILE__))
require 'lib/no_www'
require 'lib/redirect_to_tld'
use NoWWW
use RedirectToTLD, 'stevenwilkin.com'

require 'stevenwilkin.com.rb'
run StevenWilkinDotCom
