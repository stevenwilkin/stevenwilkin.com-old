require File.expand_path(File.join(File.dirname(__FILE__), 'spec_helper'))

describe "The Contact Page" do
  include Rack::Test::Methods

  it "should respond to a POST Request" do
    post '/contact'
    last_response.should be_ok
  end

  context "email address regular expression" do
    it "should recognise invalid addresses" do
      ('user@domain' =~ EMAIL_REGEX).should be_false
    end

    it "should recognise valid addresses" do
      ('user@domain.com' =~ EMAIL_REGEX).should be_true
    end
  end

end
