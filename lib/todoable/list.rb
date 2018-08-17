# frozen_string_literal: true

require 'httparty'
require 'json'

module Todoable
  class Client
    module List
      def lists
        request(method: :get, endpoint: '/lists')
      end

      def find(id)
        response = HTTParty.get("#{API_URL}/lists/#{id}")
        attributes = JSON.parse(response.body)
        new(attributes)
      end
    end
  end
end