# frozen_string_literal: true

require 'httparty'
require 'json'

module Todoable
  class Client
    module List
      def lists
        response = request(method: :get, endpoint: '/lists')
        { 'body' => response.parsed_response, 'code' => response.code }
      end

      def new_list(name:)
        list_body = { 'list' => {'name' => name } }
        response = request(method: :post, endpoint: '/lists', params: list_body)
        { 'body'=> response.parsed_response, 'code' => response.code }
      end

      def find_list(id:)
        response = request(method: :get, endpoint: "/lists/#{id}")
        { 'body' => response.parsed_response, 'code' => response.code }
      end

      def update_list(id:, name:)
        list_body = { 'list' => {'name' => name } }
        response = request(method: :patch, endpoint: "/lists/#{id}",
                           params: list_body)
        { 'body' => response.body, 'code' => response.code }
      end

      def delete_list(id:)
        response = request(method: :delete, endpoint: "/lists/#{id}")
        { 'body' => response.parsed_response, 'code' => response.code }
      end
    end
  end
end