require "prtg/utils"

describe Prtg::Utils, "url_params" do
  it "converts an hash to url params" do
    Prtg::Utils.url_params(:login => "foo", :pw => "bar").should eq("login=foo&pw=bar")
  end

  it "escapes the params for url" do
    Prtg::Utils.url_params(:login => "fo$", :pw => "bar").should eq("login=fo%24&pw=bar")
  end
end
