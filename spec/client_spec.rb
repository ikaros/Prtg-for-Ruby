require "prtg/client"

require  File.dirname(__FILE__) + "/helpers/client_helper_methods.rb"


describe Prtg::Client, "getpasshash" do

  include ClientHelperMethods

  it "request the hash via the given host" do

    expected_params = ["/api/getpasshash.htm?username=foo&password=bar",
                       {"accept-encoding"=>"gzip"}]

    client = create_client
    client.host.should_receive(:get).with(*expected_params).
                and_return(create_response("111111"))
    client.getpasshash
  end
end

describe Prtg::Client, "initialize" do

  include ClientHelperMethods

  it "raises an ArgumentError if no host is given" do
    lambda{ Prtg::Client.new() }.should raise_error(ArgumentError)
  end
end

describe Prtg::Client, "passhash" do

  include ClientHelperMethods

  it "uses the getpasshash method" do
    client = create_client
    client.should_receive(:getpasshash).and_return("1111111")
    client.passhash.should eq("1111111")
  end
end

describe Prtg::Client, "live_data" do

  include ClientHelperMethods

  it "instance a Prtg::Query" do
    client  = create_client
    content = :sensors
    Prtg::Query.should_receive(:new).with(client, content).and_return(true)
    client.live_data(content)
  end

  it "parse the response xml" do
    client = create_client(:passhash => "1111111")
    client.host.expects(:get).returns(create_response(xml_sensor_set))
    result = client.live_data(:sensors).execute
    result = Prtg::LiveDataResponse
  end
end
