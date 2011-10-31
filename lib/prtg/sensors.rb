require "net/https"
require "uri"
require "cgi"
require "prtg/query"
require "prtg/utils"
require "happymapper"

module Prtg # :nodoc:
  class Sensors
    include HappyMapper

    tag 'sensors'
    has_many :sensors, Prtg::Sensor
  end
end
