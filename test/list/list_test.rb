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
      list = @client.new_list('Awesome list')
      response = @client.find_list(list['id'])
      assert_equal 'Awesome list', response['name']
    end
  end

  def test_it_updates_a_list
    setup
    VCR.use_cassette('update_a_list') do
      list = @client.new_list('Neato list')
      response = @client.update_list(list['id'], 'Not really a neat list')
      assert_equal 'Not really a neat list updated', response.body
      assert_equal 200, response.code
    end
  end

  def test_deleting_a_list
    setup
    VCR.use_cassette('delete_a_list') do
      list = @client.new_list('Lame list')
      response = @client.delete_list(list['id'])
      assert_equal 204, response.code
    end
  end
end