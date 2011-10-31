require "net/https"
require "uri"
require "cgi"
require "prtg/query"
require "prtg/utils"
require "happymapper"

module Prtg # :nodoc:
  class Sensor

    include HappyMapper

    tag 'item'

    element :objid, Integer
    element :type, String
    element :downtime, String
    element :downtime_raw, Integer
    element :downtimetime, String
    element :downtimetime_raw, Integer
    element :downtimesince, String
    element :downtimesince_raw, Integer
    element :uptime, String
    element :uptime_raw, Integer
    element :uptimetime, String
    element :uptimetime_raw, Integer
    element :uptimesince, String
    element :uptimesince_raw, Integer
    element :knowntime_raw, Integer
    element :cumsince_raw, Integer
    element :sensor, String
    element :interval, String
    element :interval_raw, Integer
    element :device, String
    element :group, String
    element :probe, String
    element :grpdev, String
    element :notifiesx, String
    element :intervalx, String
    element :interval_raw, Integer
    element :access, String
    element :dependency, String
    element :dependency_raw, String
    element :probegroupdevice_raw, String
    element :status, String

    # 1=Unknown    4=Warning    7=Paused by User        10=Unusual
    # 2=Scanning   5=Down       8=Paused by Dependency  11=Not Licensed
    # 3=Up         6=No Probe   9=Paused by Schedule    12=Paused Until
    element :status_raw, Integer
    element :message_raw, String
    element :priority, Integer
    element :lastvalue, String
    element :favorite_raw, String
    element :minigraph, String
  end
end
