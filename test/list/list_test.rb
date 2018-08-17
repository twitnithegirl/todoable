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
    VCR.use_cassette('all_lists') do
      lists = @client.lists
      assert_equal [], lists['lists']
    end
  end

  def test_it_makes_a_list
    setup
    VCR.use_cassette('make_a_list') do
      response = @client.new_list('Exciting new list')
      assert_equal 'Exciting new list', response['name']
    end
  end

  def test_it_finds_a_list
    setup
    VCR.use_cassette('find_a_list') do
      list = @client.new_list('My great list')
      response = @client.find_list(list['id'])
      assert_equal 'My great list', response['name']
    end
  end
end