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
      response = @client.new_list(name: 'Exciting new todoable')
      assert_equal 'Exciting new todoable', response['name']
    end
  end

  def test_it_finds_a_list
    setup
    VCR.use_cassette('find_a_list') do
      list = @client.new_list(name: 'Doot Doot')
      response = @client.find_list(id: list['id'])
      assert_equal 'Doot Doot', response['name']
    end
  end

  def test_it_updates_a_list
    setup
    VCR.use_cassette('update_a_list') do
      list = @client.new_list(name: 'Neat todoable')
      response = @client.update_list(id: list['id'], name: 'Not really neat')
      assert_equal 'Not really neat updated', response.body
      assert_equal 200, response.code
    end
  end

  def test_deleting_a_list
    setup
    VCR.use_cassette('delete_a_list') do
      list = @client.new_list(name: 'Lame todoot')
      response = @client.delete_list(id: list['id'])
      assert_equal 204, response.code
    end
  end
end