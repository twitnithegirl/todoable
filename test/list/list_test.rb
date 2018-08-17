require_relative '../test_helper'

class TodoableListTest < Minitest::Test

  def setup
    VCR.use_cassette('valid') do
      @client = Todoable::Client.new(username: 'britnialexander@gmail.com',
                                    password: 'todoable')
    end
  end

  def test_it_gets_all_the_lists
    setup
    VCR.use_cassette('one_list') do
      lists = @client.lists
      assert_equal [], lists['lists']
    end
  end
end