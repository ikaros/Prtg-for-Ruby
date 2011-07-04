module Prtg # :nodoc:

  # Proxy class to caspule request
  class Query

    # Blank slate
    # This class has no methods except for __send__ and __id__
    # instance_methods.each { |m| undef_method m unless m =~ /^__/ }

    def initialize(client)
      @client = client
      @output = :xml
    end

    def columns(*args)
      @columns = @columns ? (@columns | args) : args
      self
    end

    # This single values for the query.
    # They are pretty much like sql.
    #
    # content is like a table
    # count is like LIMIT
    # start is like OFFSET
    QUERY_VALUES = %w[content count start output]

    QUERY_VALUES.each do |value_field|
      define_method value_field do |value|
        instance_variable_set "@#{value_field}", value
        self
      end
    end

   #  def method_missing(*args)
   #    evaluate.send(*args)
   #  end
  end
end
