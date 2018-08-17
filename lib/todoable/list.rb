require 'httparty'
require 'json'

module Todoable
  class List
    attr_reader :name, :items

    def initialize(attributes)
      @name = attributes["name"]
      @items = attributes["items"]
    end

    def self.find(id)
      response = HTTParty.get("#{API_URL}/lists/#{id}")
      attributes = JSON.parse(response.body)
      new(attributes)
    end
  end
end