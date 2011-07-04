require "cgi"

module Prtg # :nodoc:

  module Utils

    # Convert hashes to get parameters
    #
    # Example:
    #   Utils.url_params(name: "foo", login: "bar") #=> "name=foo&login=bar"
    #
    def self.url_params(params)
      url_params = []

      params.each do |key, value|
        url_params << "#{CGI.escape(key.to_s)}=#{[*value].map{|v| CGI.escape(v.to_s)}.join(",")}"
      end

      url_params.join("&")
    end
  end
end
