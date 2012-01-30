# encoding: utf-8
dir = File.dirname(__FILE__)
$LOAD_PATH.unshift dir unless $LOAD_PATH.include?(dir)
require "rubygems"
require "#{dir}/prtg/client"
require "#{dir}/prtg/query"
require "#{dir}/prtg/utils"

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
  VERSION = "0.0.1p3"
end
