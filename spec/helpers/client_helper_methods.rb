require "mocha/api"

module ClientHelperMethods
  def create_host
    host = Net::HTTP.new("https://127.0.0.1", 433)
    host.use_ssl = true
    host.verify_mode = OpenSSL::SSL::VERIFY_NONE
    host
  end

  def create_client(params={})
    params = {:host => create_host,
              :username => "foo",
              :password => "bar"}.merge(params)
    Prtg::Client.new(params)
  end

  def create_response(content)
    response = double('Net::HTTPResponse')
    response.stubs(:code => '200',
                   :message => "OK",
                   :content_type => "text/html",
                   :body => content)
    response
  end

  def create_query(client=create_client, content=:sensors)
    Prtg::LiveDataQuery.new(client, content)
  end

  Dir.glob("#{File.dirname(__FILE__)}/../xml/*.xml") do |path|
    filename = File.basename(path, ".xml")

    define_method("xml_" << filename) do
      instance_variable_get("@#{filename}") || instance_variable_set("@#{filename}", File.read(path))
    end
  end
end
