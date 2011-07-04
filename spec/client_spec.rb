require "prtg/client"
require  File.dirname(__FILE__) + "/helpers/client_helper_methods.rb"


describe Prtg::Client, "getpasshash" do

  include ClientHelperMethods

  it "request the hash via the given host" do
    expected_url = "/api/getpasshash.htm?username=foo&password=bar"
    client = create_client
    client.host.should_receive(:get).with(expected_url).and_return(create_response("111111"))
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
    client = create_client
    Prtg::Query.should_receive(:new).with(client).and_return(true)
    client.live_data
  end
end

# describe Prtg::Client, "devices" do
#
#   include ClientHelperMethods
#
#   it "should return an hash" do
#     client = create_client
#     client.host.should_receive(:get).and_return(create_response(<<-XML))
# <?xml version="1.0" encoding="UTF-8" ?>
#   <devices>
#    <prtg-version>8.4.2.2321</prtg-version>
#    <item>
#     <objid>2002</objid>
#     <probe>prtgx (Strato)</probe>
#     <group>Windows</group>
#     <device>Homepage Calls</device>
#     <host>127.0.0.1</host>
#     <downsens_raw>0000000001</downsens_raw>
#     <partialdownsens_raw>0000000000</partialdownsens_raw>
#     <downacksens_raw>0000000000</downacksens_raw>
#     <upsens_raw>0000000033</upsens_raw>
#     <warnsens_raw>0000000000</warnsens_raw>
#     <pausedsens_raw>0000000002</pausedsens_raw>
#     <unusualsens_raw>0000000000</unusualsens_raw>
#     <undefinedsens_raw>0000000000</undefinedsens_raw>
#    </item>
#    <item>
#     <objid>2057</objid>
#     <probe>prtgx (Strato)</probe>
#     <group>Windows</group>
#     <device>SSL Expiry Checks</device>
#     <host>127.0.0.1</host>
#     <downsens_raw>0000000000</downsens_raw>
#     <partialdownsens_raw>0000000000</partialdownsens_raw>
#     <downacksens_raw>0000000000</downacksens_raw>
#     <upsens_raw>0000000016</upsens_raw>
#     <warnsens_raw>0000000001</warnsens_raw>
#     <pausedsens_raw>0000000001</pausedsens_raw>
#     <unusualsens_raw>0000000001</unusualsens_raw>
#     <undefinedsens_raw>0000000000</undefinedsens_raw>
#    </item>
# </devices>
#     XML
#     client.devices.should be_a(Hash)
#   end
# end
