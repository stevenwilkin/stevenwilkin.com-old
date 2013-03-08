require File.expand_path(File.join(File.dirname(__FILE__), 'spec_helper'))

require 'pony-test'

describe "The Contact Page" do
  include Rack::Test::Methods
  include Pony::TestHelpers

  let(:name) { 'Bob' }
  let(:email) { 'bob@bob.com' }
  let(:message) { 'hello' }

  before do
    reset_mailer
  end

  it "should respond to a POST Request" do
    post '/contact'
    last_response.should be_ok
  end

  context "email address regular expression" do
    it "should recognise invalid addresses" do
      ('user@domain' =~ EMAIL_REGEX).should be_false
    end

    it "should recognise valid addresses" do
      (email =~ EMAIL_REGEX).should be_true
    end
  end

  it "should send an email when valid form fields are supplied" do
    post '/contact', {:name => name, :email => email, :message => message}
    deliveries.count.should eql 1
  end

  it "should contain the supplied details in the email body" do
    post '/contact', {:name => name, :email => email, :message => message}
    for field in[name, email, message] do
      current_email.body.should include field
    end
  end
end
