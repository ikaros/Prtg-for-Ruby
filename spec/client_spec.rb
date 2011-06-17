require "prtg/client"
require "mocha"


def create_host
  host = Net::HTTP.new("https://127.0.0.1", 433)
  host.use_ssl = true
  host.verify_mode = OpenSSL::SSL::VERIFY_NONE
  host
end

def create_client
  Prtg::Client.new(
    :host => create_host,
    :username => "foo",
    :password => "bar")
end

def create_response(content)
  response = mock('Net::HTTPResponse')
  response.stubs(:code => '200',
                 :message => "OK",
                 :content_type => "text/html",
                 :body => content)
  response
end

describe Prtg::Client, "getpasshash" do

  it "request the hash via the given host" do
    expected_url = "/api/getpasshash.htm?username=foo&password=bar"
    client = create_client
    client.host.should_receive(:get).with(expected_url).and_return(create_response("111111"))
    client.getpasshash
  end
end

describe Prtg::Client, "initialize" do
  it "raises an ArgumentError if no host is given" do
    lambda{ Prtg::Client.new() }.should raise_error(ArgumentError)
  end
end

describe Prtg::Client, "passhash" do
  it "uses the getpasshash method" do
    client = create_client
    client.should_receive(:getpasshash).and_return("1111111")
    client.passhash.should eq("1111111")
  end
end

