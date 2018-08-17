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
      assert_equal [], lists['body']['lists']
      assert_equal 200, lists['code']
    end
  end

  def test_it_makes_a_list
    setup
    VCR.use_cassette('make_a_list') do
      response = @client.new_list(name: 'Exciting new listy')
      assert_equal 'Exciting new listy', response['body']['name']
      assert_equal 201, response['code']
    end
  end

  def test_it_does_not_make_duplicate_lists
    setup
    VCR.use_cassette('make_a_duplicate_list') do
      @client.new_list(name: 'Woohoo, a list')
      response = @client.new_list(name: 'Woohoo, a list')
      assert_equal 422, response['code']
    end
  end

  def test_it_finds_a_list
    setup
    VCR.use_cassette('find_a_list') do
      list = @client.new_list(name: 'Doot Doodlety Doot')
      response = @client.find_list(id: list['body']['id'])
      assert_equal 'Doot Doodlety Doot', response['body']['name']
      assert_equal 200, response['code']
    end
  end

  def test_it_gives_an_error_when_the_list_does_not_exist
    setup
    VCR.use_cassette('find_a_fake_list') do
      response = @client.find_list(id: 5)
      assert_equal 404, response['code']
    end
  end

  def test_it_updates_a_list
    setup
    VCR.use_cassette('update_a_list') do
      list = @client.new_list(name: 'Neato torpedoz')
      response = @client.update_list(id: list['body']['id'], name: 'No more torpedoez')
      assert_equal 'No more torpedoez updated', response['body']
      assert_equal 200, response['code']
    end
  end

  def test_deleting_a_list
    setup
    VCR.use_cassette('delete_a_list') do
      list = @client.new_list(name: 'Lame todoot')
      response = @client.delete_list(id: list['body']['id'])
      assert_equal 204, response['code']
    end
  end
end