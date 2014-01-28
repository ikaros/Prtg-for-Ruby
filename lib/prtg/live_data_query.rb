module Prtg # :nodoc:

  # Proxy class to caspule request
  class LiveDataQuery

    # BlankSlate
    instance_methods.each { |m| undef_method m unless m =~ /^(__|send|object_id)/ }

    def initialize(client, content)
      @prtg_client = client
      @query_hash = {}
      @query_hash[:output]  = :xml
      @query_hash[:content] = content
    end

    # This single values for the query.
    # They are pretty much like sql.
    #
    # content is like a table
    # count is like LIMIT
    # start is like OFFSET
    VALUES = [:count, :start, :output, :id]

    VALUES.each do |key|
      define_method key do |value|
        @query_hash[key] = value
        self
      end
    end

    MULTIPLE_VALUES = [:columns]

    MULTIPLE_VALUES.each do |key|
      define_method key do |*args|
        @query_hash[key] = (@query_hash[key] || []) | args
        self
      end
    end

   def execute
     @prtg_client.api_request(@query_hash)
   end

   private

   def add_filter(name, value)
     @query_hash[name.to_sym] = value
     self
   end

   def method_missing(*args, &block)
     if args.first.to_s.start_with? "filter"
       add_filter(*args)
     else
       execute.send(*args, &block)
     end
   end

  end
end
