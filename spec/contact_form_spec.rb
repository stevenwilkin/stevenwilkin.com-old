require File.expand_path(File.join(File.dirname(__FILE__), 'spec_helper'))

describe "The Contact Page" do
  include Rack::Test::Methods

  it "should respond to a POST Request" do
    post '/contact'
    last_response.should be_ok
  end

end
