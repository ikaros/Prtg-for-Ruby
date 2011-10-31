require "prtg/utils"

describe Prtg::Utils, "url_params" do
  it "converts an hash to url params" do
    Prtg::Utils.url_params(:login => "foo", :pw => "bar").should satisfy do |url|
      url["pw=bar"] &&
      url["&"] &&
      url["login=foo"]
    end
  end

  it "escapes the params for url" do
    Prtg::Utils.url_params(:login => "fo$", :pw => "bar").should satisfy do |url|
      url["login=fo%24"] &&
      url["&"] &&
      url["pw=bar"]
    end
  end

  it "converts array to comma seperated values" do
    Prtg::Utils.url_params(:columns => [:id, :tags]).
      should eql("columns=id,tags")
  end
end
