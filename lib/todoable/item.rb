# frozen_string_literal: true

require 'httparty'
require 'json'

module Todoable
  class Client
    module Item
      def new_item(list_id:, name:)
        item_body = { 'item' => {'name' => name } }
        response = request(method: :post,
                           endpoint: "/lists/#{list_id}/items",
                           params: item_body)
        { 'body' => response.parsed_response, 'code' => response.code }
      end

      def finish_item(list_id:, item_id:)
        response = request(method: :put,
                           endpoint: "/lists/#{list_id}/items/#{item_id}/finish")
        { 'body' => response.body, 'code' => response.code }
      end

      def delete_item(list_id:, item_id:)
        response = request(method: :delete,
                           endpoint: "/lists/#{list_id}/items/#{item_id}")
        { 'body' => response.parsed_response, 'code' => response.code }
      end
    end
  end
end
