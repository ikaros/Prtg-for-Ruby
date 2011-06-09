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

      params.to_a.each do |key_and_value|
        url_params << key_and_value.map{|s| CGI.escape(s.to_s)}.join("=")
      end

      url_params.join("&")
    end
  end
end
