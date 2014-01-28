require "prtg/client"
require "prtg/live_data_query"
require "mocha/api"
require  File.dirname(__FILE__) + "/helpers/client_helper_methods.rb"

Prtg::LiveDataQuery::MULTIPLE_VALUES.each do |value|
  describe Prtg::LiveDataQuery, value.to_s do

    include ClientHelperMethods

    it "adds #{value} to query" do
      client = double('Prtg::Client')
      client.should_receive(:api_request).
             with(hash_including(value => [:tags]))

      create_query(client).
        send(value, :tags).
        execute
    end

    it "adds multiple #{value} to query at once" do
      client = double('Prtg::Client')
      client.should_receive(:api_request).
             with(hash_including(value => [:objid, :tags]))

      create_query(client).
        send(value, :objid, :tags).
        execute
    end

    it "adds multiple #{value} to query step by step" do
      client = double('Prtg::Client')
      client.should_receive(:api_request).
             with(hash_including(value => [:objid, :tags]))

      create_query(client).
        send(value, :objid).
        send(value, :tags).
        execute
    end
  end
end

Prtg::LiveDataQuery::VALUES.each do |value|
  describe Prtg::LiveDataQuery, value.to_s do

    include ClientHelperMethods

    it "sets the query's #{value}" do
      client = double('Prtg::Client')
      client.should_receive(:api_request).
             with(hash_including(value => 100))

      create_query(client).
        send(value, 100).
        execute
    end

    it "overwrites the query's #{value}" do
      client = double('Prtg::Client')
      client.should_receive(:api_request).
             with(hash_including(value => 100))

      create_query(client).
        send(value, 40).
        send(value, 100).
        execute
    end
  end
end


describe Prtg::LiveDataQuery, "output" do

  include ClientHelperMethods

  it "has :xml as default value" do
    client = double('Prtg::Client')
    client.should_receive(:api_request).
           with(hash_including(:output => :xml))

    create_query(client).
      execute
  end
end

describe Prtg::LiveDataQuery, "execute" do

  include ClientHelperMethods

  it "call the clients 'api_request' instance method" do
    client = double('Prtg::Client')
    client.should_receive(:api_request).
           with(hash_including(:columns => [:id, :tags,], :count => 100))

    create_query(client).
      columns(:id).
      columns(:tags).
      count(100).
      execute
  end

  it "forwards the result of execute on method missing" do
    result= double("String")
    result.should_receive(:size).
           and_return(4)


    client = double('Prtg::Client')
    client.should_receive(:api_request).
           and_return(result)

    query = create_query(client).size

  end
end

describe Prtg::LiveDataQuery, "add_filter" do

  include ClientHelperMethods

  it "should add a filter rule to the query " do
    client = double('Prtg::Client')
    client.should_receive(:api_request).
           with(hash_including(:filter_tags => :http_sensor))

    create_query(client).
      filter_tags(:http_sensor).
      execute
  end
end
