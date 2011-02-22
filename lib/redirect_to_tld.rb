# ensure all requests are served from a canonical top-level-domain
#
# the following in your config.ru will cause all traffic to stevenwilkin.co.uk to
# be redirected to stevenwilkin.com if both domains are served by the same app
#
# use RedirectToTLD, 'stevenwilkin.com'
#
class RedirectToTLD

  def initialize(app, tld = nil)
    @app = app
    @tld = tld
  end
  
  def call(env)
    if ENV['RACK_ENV'] == 'production' and @tld and env['HTTP_HOST'] !~ /#{@tld}/
      [301, {'Location' => Rack::Request.new(env).url.sub(/#{env['HTTP_HOST']}/, @tld),
            'Content-Type' => 'text/plain'}, ['Redirecting...']]
    else
      @app.call(env)
    end
  end
  
end
