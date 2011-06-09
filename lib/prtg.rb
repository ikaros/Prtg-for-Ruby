# encoding: utf-8
require "open-uri"

module Prtg
  require File.dirname(__FILE__) + "/prtg/connector.rb"
  require File.dirname(__FILE__) + "/prtg/utils.rb"

  # Gives you the passhash provided by the prtg instance
  #
  # Example
  #   Prtg.request_passhash(host: "https://myprtg",
  #                         username: "foo",
  #                         :password: "bar")
  #   #=> "12378237"
  def self.request_passhash(args)

    [:host, :username, :password].each do |arg|
      args[arg] or raise ArgumentError.new("No #{arg} given.")
    end

    options = args.delete(:options)
    host    = args.delete(:host)
    url = "#{host}/api/getpasshash.htm?#{Utils.url_params(args)}"
    OpenURI.open_uri(url, options).read
  end

end
