# encoding: utf-8
require "rubygems"
require "happymapper"

require "prtg/client"
require "prtg/query"
require "prtg/sensor"
require "prtg/device"
require "prtg/life_data_response"
require "prtg/utils"

# This is a wrapper for the api of paessler's prtg monitoring tool.
#
# Simple Example:
#   http = Net::HTTP.new("subdomain.domain.tld", 443)
#   http.use_ssl = true
#   http.verify_mode = OpenSSL::SSL::VERIFY_NONE
#
#   client = Prtg::Client.new(:host => http, :username => "foo", :password => "bar")
#   p client.live_data(:sensors)
module Prtg
  VERSION = "0.0.1"
end
