require "prtg/query"

module Prtg # :nodoc

  # Proxy class to caspule request
  class HistoricDataQuery

    include Prtg::Query

    api_url '/api/historicdata.xml'

    VALUES = [:id, :sdate, :edate, :avg]
    VALUES.each { |k| api_value k }

  end
end
