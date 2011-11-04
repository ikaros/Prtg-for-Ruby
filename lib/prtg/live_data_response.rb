require "happymapper"
require "prtg/device"
require "prtg/sensor"

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

  end
end
