require 'faraday'
require 'faraday_middleware'

module IuguLite
  class << self

    def client 
      @client ||= new_connection
    end

    private

    def new_connection
      Faraday.new(
        url: iugu_lite_uri, 
        params: { invoice_token: '' }
      ) do |faraday|
        faraday.headers['Content-Type'] = 'application/json'
        faraday.response :json, parser_options: { symbolize_names: true},
                                content_type: /\bjson$/
        faraday.adapter :net_http
      end
    end

    def iugu_lite_uri
      "#{endpoint}/api/#{api_version}/"
    end

    def endpoint
      #endpoint
    end

    def api_version
      'v1'
    end
  end
end