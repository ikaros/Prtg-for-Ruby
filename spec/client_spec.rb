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

describe Prtg::Client, "getstatus" do

  include ClientHelperMethods

  it "should return the current prtg status" do
    client = create_client(:passhash => "1111111")
    client.host.expects(:get).returns(create_response(xml_getstatus))
  end
end

describe Prtg::Client, "table" do

  include ClientHelperMethods

  it "parse the response xml" do
    client = create_client(:passhash => "1111111")
    client.host.expects(:get).returns(create_response(xml_sensor_set))
    client.table.content(:sensors).should eql [

      { "objid" =>"100001",
        "probe" =>"prtg HORST 10.10.10.10",
        "group" => "Switches",
        "device" => "onetcore1",
        "sensor" => "PING",
        "status" => "Up",
        "status_raw" => "3",
        "message_raw" => "OK",
        "lastvalue" => "2 msec",
        "lastvalue_raw" => "2.0000",
        "priority" => "5",
        "favorite_raw" => "0"},

      { "objid" => "100002",
        "probe" => "prtg HORST 10.10.10.10",
        "group" => "Switches",
        "device" => "onettt001",
        "sensor" => "PING",
        "status" => "Up",
        "status_raw" => "3",
        "message_raw" => "OK",
        "lastvalue" => "0 msec",
        "lastvalue_raw" => "0.0000",
        "priority" => "5",
        "favorite_raw" => "0"}
    ]
  end
end
