require "happymapper"

module Prtg # :nodoc:
  class LiveDataResponse

    include HappyMapper

    tag :sensors
    has_many :sensors, Prtg::Sensor


  end
end
