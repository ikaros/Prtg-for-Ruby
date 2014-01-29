require "prtg/query"
module Prtg # :nodoc:

  # Proxy class to caspule request
  class LiveDataQuery

    include Prtg::Query

    VALUES = [:content, :count, :start, :output, :id]
    VALUES.each { |k| api_value k }

    MULTIPLE_VALUES = [:columns]
    MULTIPLE_VALUES.each { |k| api_list k }

  end
end
