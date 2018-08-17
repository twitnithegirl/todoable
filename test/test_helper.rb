# frozen_string_literal = true

require './lib/todoable'
require 'minitest/autorun'
require 'webmock/minitest'
require 'vcr'
require 'pry'

VCR.configure do |c|
  c.cassette_library_dir = "test/fixtures"
  c.hook_into :webmock
end