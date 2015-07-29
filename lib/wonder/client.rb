require 'faraday'
require 'builder'
require 'oga'

module Wonder
    class Client
      attr_accessor :client
      attr_accessor :database
      attr_accessor :request_parameters
      attr_accessor :data

      def initialize
        @request_parameters = {}
        set_client if @client.nil?
        set_parameters
        @data = []
        @client
      end

      def set_parameters
        @request_parameters.merge!(default_parameters)
      end

      def default_parameters
        {}
      end

      def set_client
        @client = Faraday.new(:url => 'http://wonder.cdc.gov/controller/datarequest/') do |faraday|
          faraday.request  :url_encoded
          faraday.adapter  Faraday.default_adapter
        end
        @client
      end

      def request_xml
        @request_object = Builder::XmlMarkup.new
        @request_object.instruct!( :xml, :version=>"1.0", :encoding=>"UTF-8")
        @request_object.tag!('request-parameters') do |r|
          r.tag!('parameter') { |t| t.name('accept_datause_restrictions'); t.value(true)}
          @request_parameters.keys.each do |p|
            r.tag!('parameter') { |v| v.name(p); v.value(@request_parameters[p])}
          end
          r.tag!('parameter') { |t| t.name('action-Send'); t.value('Send')}
          r.tag!('parameter') { |t| t.name('stage'); t.value('request')}
        end
      end

  end
end