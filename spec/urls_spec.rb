require File.expand_path(File.join(File.dirname(__FILE__), 'spec_helper'))

describe "My Site" do
  include Rack::Test::Methods

  it "should have a home page" do
    get '/'
    last_response.should be_ok
  end

  it "should have a cv page" do
    get '/cv'
    last_response.should be_ok
  end

  it "should have a projects page" do
    get '/projects'
    last_response.should be_ok
  end

  it "should have a contact page" do
    get '/contact'
    last_response.should be_ok
  end

  it "should respond with a 404 for a non-existant page" do
    get '/nosuchpage'
    last_response.status.should == 404
  end
end
