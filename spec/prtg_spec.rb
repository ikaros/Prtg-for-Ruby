require "prtg"

describe Prtg, "request_passhash" do

  before do
    @valid_args = {host: "https://127.0.0.1", username: "foo", password: "bar"}
  end

  [:host, :username, :password].each do |arg|
    it "raises an ArgumentError if no #{arg} is given" do
      @valid_args.delete(arg)
      lambda{ Prtg.request_passhash(@valid_args) }.should raise_error(ArgumentError)
    end
  end

  it "passes provided options to OpenURI.open" do

    expected_url = "https://127.0.0.1/api/getpasshash.htm?username=foo&password=bar"
    @valid_args[:options] = {proxy: false}

    OpenURI.should_receive(:open_uri).
            with(expected_url, @valid_args[:options]).
            and_return(StringIO.new("1111111111"))

    Prtg.request_passhash(@valid_args)
  end
end
