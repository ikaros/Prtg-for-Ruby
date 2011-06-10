require "open-uri"
require "cgi"
require "prtg/utils"

module Prtg # :nodoc:
  module Connector
    module ClassMethods

      # Gives you the passhash provided by the prtg instance
      #
      # Example
      #   Prtg.request_passhash(host: "https://myprtg",
      #                         username: "foo",
      #                         :password: "bar")
      #   #=> "12378237"
      def request_passhash(args)

        [:host, :username, :password].each do |arg|
          args[arg] or raise ArgumentError.new("No #{arg} given.")
        end

        options = args.delete(:options)
        host    = args.delete(:host)
        url = "#{host}/api/getpasshash.htm?#{Utils.url_params(args)}"
        OpenURI.open_uri(url, options).read
      end
    end

    module InstanceMethods

    end

    def self.included(receiver)
      receiver.extend         ClassMethods
      receiver.send :include, InstanceMethods
    end
  end
end
