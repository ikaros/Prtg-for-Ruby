require "mocha"

module ClientHelperMethods
  def create_host
    host = Net::HTTP.new("https://127.0.0.1", 433)
    host.use_ssl = true
    host.verify_mode = OpenSSL::SSL::VERIFY_NONE
    host
  end

  def create_client
    Prtg::Client.new(
      :host => create_host,
      :username => "foo",
      :password => "bar")
  end

  def create_response(content)
    response = mock('Net::HTTPResponse')
    response.stubs(:code => '200',
                   :message => "OK",
                   :content_type => "text/html",
                   :body => content)
    response
  end

  def create_query(client=create_client)
    Prtg::Query.new(client)
  end
end
