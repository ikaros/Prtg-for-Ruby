module Prtg # :nodoc:

  module Query

    module ClassMethods

      def api_url(url)
        define_method(:api_url) { url }
      end

      def api_value(name)
        define_method name do |value|
          @query[name] = value
          self
        end
      end

      def api_list(name)
        define_method name do |*args|
          @query[name] = (@query[name] || []) | args
          self
        end
      end

    end

    module InstanceMethods

      def initialize(host, auth_params={})
        @host = host
        @query = {}.merge(auth_params)
        @query[:output]  = :xml
      end

      def execute
        url_params = Utils.url_params(@query)

        parse_response @host.get(
          "#{ api_url }?#{ url_params }",
          { "Accept-Encoding" => "*"}
        )
      end

      def add_filter(name, value)
        @query[name.to_sym] = value
        self
      end

      def method_missing(*args, &block)
        if args.first.to_s.start_with? "filter"
          add_filter(*args)
        else
          execute.send(*args, &block)
        end
      end

      private

      def parse_response(response)
        hash = XmlSimple.xml_in(response.body, "ForceArray" => false)

        if hash["error"]
          raise hash["error"]

        else
          hash["item"]
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
