require_relative '../test_helper'

class TodoableListTest < Minitest::Test

  def setup
    VCR.use_cassette('item_validation') do
      @client = Todoable::Client.new(username: 'britnialexander@gmail.com',
                                     password: 'todoable')
      @list = @client.new_list('List with new items in it')
    end
  end

  def test_it_makes_an_item
    setup
    VCR.use_cassette('make_an_item') do
      response = @client.new_item(list_id: @list['id'], name: 'Workout')
      assert_equal 201, response.code
    end
  end

  def test_it_marks_an_item_finished
    setup
    VCR.use_cassette('mark_item_finished') do
      item = @client.new_item(list_id: @list['id'], name: 'Call mom')
      response = @client.finish_item(list_id: @list['id'], item_id: item['id'])
      assert_equal 200, response.code
    end
  end

  def test_it_deletes_an_item
    setup
    VCR.use_cassette('delete_an_item') do
      item = @client.new_item(list_id: @list['id'], name: 'Lame todootle doo')
      response = @client.delete_item(list_id: @list['id'], item_id: item['id'])
      assert_equal 204, response.code
    end
  end
end