require "happymapper"
require "prtg/device"
require "prtg/sensor"
require "prtg/value"

module Prtg # :nodoc:
  module LiveDataResponse

    class Sensors
      include HappyMapper
      tag :sensors
      has_many :sensors, Prtg::Sensor
    end

    class Devices
      include HappyMapper
      tag :devices
      has_many :devices, Prtg::Device
    end

    class Values
      include HappyMapper
      tag :values
      has_many :values, Prtg::Value
    end

  end
end
