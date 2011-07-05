require "prtg/client"
require "prtg/query"
require "mocha"
require  File.dirname(__FILE__) + "/helpers/client_helper_methods.rb"


Prtg::Query::MULTIPLE_VALUES.each do |value|
  describe Prtg::Query, value.to_s do

    include ClientHelperMethods

    it "adds #{value} to query" do
      create_query.
        send(value, :tags).
        send(:instance_variable_get, "@query_hash")[value].
        should eql([:tags])
    end

    it "adds multiple #{value} to query at once" do
      create_query.
        send(value, :objid, :tags).
        send(:instance_variable_get, "@query_hash")[value].
        should eql([:objid, :tags])
    end

    it "adds multiple #{value} to query step by step" do
      create_query.
        send(value, :objid).
        send(value, :tags).
        send(:instance_variable_get, "@query_hash")[value].
        should eql([:objid, :tags])
    end
  end
end

Prtg::Query::VALUES.each do |value|
  describe Prtg::Query, value.to_s do

    include ClientHelperMethods

    it "sets the query's #{value}" do
      create_query.
        send(value, 100).
        send(:instance_variable_get, "@query_hash")[value].
        should eql(100)
    end

    it "overwrites the query's #{value}" do
      create_query.
        send(value, 40).
        send(value, 100).
        send(:instance_variable_get, "@query_hash")[value].
        should eql(100)
    end
  end
end


describe Prtg::Query, "output" do

  include ClientHelperMethods

  it "has :xml as default value" do
    create_query.
      send(:instance_variable_get, "@output").
      should eql(:xml)
  end
end

describe Prtg::Query, "execute" do

  include ClientHelperMethods

  it "call the clients 'api_request' instance method" do
    client = create_client
    client.should_receive(:api_request).with(:columns => [:id, :tags,], :count => 100).and_return("")

    create_query(client).
      columns(:id).
      columns(:tags).
      count(100).
      execute
  end
end

describe Prtg::Query, "add_filter" do

  include ClientHelperMethods

  it "should add a filter rule to the query " do
    client = mock('Prtg::Client')
    client.expects(:api_request).yields('result').with() do |hash|
      p hash
      hash.should have_key(:filter_tags)
    end

    create_query(client).
      filter_tags("monitor").
      execute
  end
end
