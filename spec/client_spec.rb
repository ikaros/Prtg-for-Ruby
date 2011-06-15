require "prtg/client"
require "mocha"

describe Prtg::Client, "request_passhash" do

  before do
    @host = Net::HTTP.new("https://127.0.0.1", 433)
    @host.use_ssl = true
    @host.verify_mode = OpenSSL::SSL::VERIFY_NONE

    @valid_args      = [@host, "foo", "bar"]
    @valid_args_hash = [:host => @host, :username => "foo", :password => "bar"]

    @response = mock('Net::HTTPResponse')
    @response.stubs(:code => '200', :message => "OK", :content_type => "text/html", :body => '111111111')
  end


  it "request the hash via the given host" do

    expected_url = "/api/getpasshash.htm?username=foo&password=bar"
    args = Hash[*[:host, :username, :password].zip(@valid_args).flatten]

    p args
    @host.should_receive(:get).with(expected_url).and_return(@response)

    Prtg::Client.new(args).getpasshash
  end
end

describe Prtg::Client, "initialize" do
  it "raises an ArgumentError if no host is given" do
    lambda{ Prtg::Client.new() }.should raise_error(ArgumentError)
  end
end
