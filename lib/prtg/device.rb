require "happymapper"

module Prtg # :nodoc:
  class Device

    include HappyMapper

    tag 'item'

    element :objid, Integer
    element :probe, String
    element :group, String
    element :device, String
    element :host, String
    element :downacksens_raw, Integer
    element :downsens_raw, Integer
    element :partialdownsens_raw, Integer
    element :pausedsens_raw, Integer
    element :undefinedsens_raw, Integer
    element :unusualsens_raw, Integer
    element :upsens_raw, Integer
    element :warnsens_raw, Integer
  end
end
