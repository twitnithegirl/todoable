# frozen_string_literal: true

require 'httparty'
require 'json'

module Todoable
  class Client
    module Item
      def new_item(list_id, name)
        item_body = { 'item' => {'name' => name } }
        request(method: :post, endpoint: "/lists/#{list_id}/items", params: item_body)
      end

      def mark_item_finished(list_id, item_id)
        request(method: :put, endpoint: "/lists/#{list_id}/items/#{item_id}/finish")
      end

      def delete_item(list_id, item_id)
        request(method: :delete, endpoint: "/lists/#{list_id}/items/#{item_id}")
      end
    end
  end
end
