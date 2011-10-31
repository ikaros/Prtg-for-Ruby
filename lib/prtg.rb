# encoding: utf-8
require "rubygems"
require "happymapper"

require "prtg/client"
require "prtg/query"
require "prtg/sensor"
require "prtg/sensors"
require "prtg/utils"

# = Description
# This library is used to communicate with a prtg monitoring instance
#
# Simple Example:
#   http = Net::HTTP.new("subdomain.domain.tld", 443)
#   http.use_ssl = true
#   http.verify_mode = OpenSSL::SSL::VERIFY_NONE
#
#   client = Prtg::Client.new(:host => http, :username => "foo", :password => "bar")
#   puts client.live_data.content(:sensors)
module Prtg
  VERSION = "0.0.1"
end
