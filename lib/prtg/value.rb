require "happymapper"

module Prtg # :nodoc:
  class Value

    include HappyMapper

    tag 'item'

    element :datetime, Time
    element :datetime_raw, Float
    element :value, Integer
    element :value_raw, Float
    element :value, String
    element :value_raw, Float
    element :value, String
    element :value_raw, Float
    element :value, String
    element :value_raw, Float
    element :value, String
    element :value_raw, Float
    element :coverage, String
    element :coverage_raw, Integer
  end
end
