module Prtg # :nodoc:

  module Query

    module ClassMethods

      def api_value(name)
        define_method name do |value|
          @query_hash[name] = value
          self
        end
      end

      def api_list(name)
        define_method name do |*args|
          @query_hash[name] = (@query_hash[name] || []) | args
          self
        end
      end

    end

    module InstanceMethods

      def initialize(client, content)
        @prtg_client = client
        @query_hash = {}
        @query_hash[:output]  = :xml
        @query_hash[:content] = content
      end

      def execute
        @prtg_client.api_request(@query_hash)
      end

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

    def self.included(receiver)
      receiver.class_exec do
        # BlankSlate
        instance_methods.each { |m| undef_method m unless m =~ /^(__|send|object_id)/ }
      end
      receiver.extend         ClassMethods
      receiver.send :include, InstanceMethods
    end

  end
end
