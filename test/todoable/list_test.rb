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
      response = @client.new_list('Exciting new todoable')
      assert_equal 'Exciting new todoable', response['name']
    end
  end

  def test_it_finds_a_list
    setup
    VCR.use_cassette('find_a_list') do
      list = @client.new_list('Doot Doot')
      response = @client.find_list(list['id'])
      assert_equal 'Doot Doot', response['name']
    end
  end

  def test_it_updates_a_list
    setup
    VCR.use_cassette('update_a_list') do
      list = @client.new_list('Neat todoable')
      response = @client.update_list(list['id'], 'Not really neat')
      assert_equal 'Not really neat updated', response.body
      assert_equal 200, response.code
    end
  end

  def test_deleting_a_list
    setup
    VCR.use_cassette('delete_a_list') do
      list = @client.new_list('Lame todoot')
      response = @client.delete_list(list['id'])
      assert_equal 204, response.code
    end
  end
end