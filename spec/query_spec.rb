require "prtg/client"
require "prtg/query"
require "mocha"
require  File.dirname(__FILE__) + "/helpers/client_helper_methods.rb"


describe Prtg::Query, "columns" do

  include ClientHelperMethods

  it "adds column to query" do
    create_query.
       columns(:tags).
       send(:instance_variable_get, "@columns").
       should eql([:tags])
  end

  it "adds multiple columns to query at once" do
    create_query.
      columns(:objid, :tags).
      send(:instance_variable_get, "@columns").
      should eql([:objid, :tags])
  end

  it "adds multiple columns to query step by step" do
    create_query.
      columns(:objid).
      columns(:tags).
      send(:instance_variable_get, "@columns").
      should eql([:objid, :tags])
  end
end

Prtg::Query::QUERY_VALUES.each do |value|
  describe Prtg::Query, value do

    include ClientHelperMethods

    it "sets the query's #{value}" do
      create_query.
        send(value, 100).
        send(:instance_variable_get, "@#{value}").
        should eql(100)
    end

    it "overwrites the query's #{value}" do
      create_query.
        send(value, 40).
        send(value, 100).
        send(:instance_variable_get, "@#{value}").
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
