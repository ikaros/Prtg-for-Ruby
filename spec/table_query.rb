require "prtg/client"
require "prtg/table_query"
require "mocha/api"
require  File.dirname(__FILE__) + "/helpers/client_helper_methods.rb"

describe Prtg::TableQuery do

  include ClientHelperMethods

  before(:each) do
    @host  = double("Net::HTTP")
    allow(@host).to receive(:get).and_return(double('Foo', body: xml_sensor_set))
    @query = Prtg::TableQuery.new(@host)
  end

  Prtg::TableQuery::MULTIPLE_VALUES.each do |value|


    describe Prtg::TableQuery, value.to_s do

      include ClientHelperMethods

      it "adds #{value} to query" do
        Prtg::Utils.should_receive(:url_params)\
            .with(hash_including(value => [:tags]))

        @query.send(value, :tags)\
              .execute
      end

      it "adds multiple #{value} to query at once" do
        Prtg::Utils.should_receive(:url_params)\
            .with(hash_including(value => [:objid, :tags]))

        @query.send(value, :objid, :tags)\
              .execute
      end

      it "adds multiple #{value} to query step by step" do

        Prtg::Utils.should_receive(:url_params)\
            .with(hash_including(value => [:objid, :tags]))

        @query.send(value, :objid)\
              .send(value, :tags)\
              .execute
      end
    end
  end

  Prtg::TableQuery::VALUES.each do |value|
    describe Prtg::TableQuery, value.to_s do

      include ClientHelperMethods

      it "sets the query's #{value}" do
        Prtg::Utils.should_receive(:url_params)\
            .with(hash_including(value => 100))

        @query.send(value, 100)\
              .execute
      end

      it "overwrites the query's #{value}" do
        Prtg::Utils.should_receive(:url_params)\
            .with(hash_including(value => 100))

        @query.send(value, 40)\
              .send(value, 100)\
              .execute
      end
    end
  end


  describe Prtg::TableQuery, "execute" do

    include ClientHelperMethods

    it "call the clients 'api_request' instance method" do
      Prtg::Utils.should_receive(:url_params)\
          .with(hash_including(:columns => [:id, :tags,], :count => 100))

      @query.columns(:id)\
            .columns(:tags)\
            .count(100)\
            .execute
    end

  end

  describe Prtg::TableQuery, "add_filter" do

    include ClientHelperMethods

    it "should add a filter rule to the query " do
      Prtg::Utils.should_receive(:url_params)\
          .with(hash_including(:filter_tags => :http_sensor))

      @query.filter_tags(:http_sensor)\
            .execute
    end
  end
end
