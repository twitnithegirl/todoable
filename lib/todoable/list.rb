# frozen_string_literal: true

require 'httparty'
require 'json'

module Todoable
  class Client
    module List
      def lists
        request(method: :get, endpoint: '/lists')
      end

      def new_list(name)
        list_body = { 'list' => {'name' => name } }
        request(method: :post, endpoint: '/lists', params: list_body)
      end

      def find(id)
        request(method: :get, endpoint: "/lists/#{id}")
      end
    end
  end
end