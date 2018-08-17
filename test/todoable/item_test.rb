require_relative '../test_helper'

class TodoableListTest < Minitest::Test

  def setup
    VCR.use_cassette('item_validation') do
      @client = Todoable::Client.new(username: 'britnialexander@gmail.com',
                                     password: 'todoable')
    end
    VCR.use_cassette('sample_list') do
      @list = @client.new_list(name: 'List with new item')
    end
  end

  def test_it_makes_an_item
    setup
    VCR.use_cassette('make_an_item') do
      response = @client.new_item(list_id: @list['id'], name: 'Workout')
      assert_equal 201, response.code
    end
  end

  def test_it_gives_an_error_then_you_try_to_make_an_item_with_nil_name
    setup
    VCR.use_cassette('make_an_item_without_name') do
      response = @client.new_item(list_id: @list['id'], name: nil)
      assert_equal 422, response.code
    end
  end

  def test_it_gives_an_error_then_you_try_to_make_an_item_with_invalid_list_id
    setup
    VCR.use_cassette('make_an_item_without_list') do
      response = @client.new_item(list_id: nil, name: 'Run')
      assert_equal 404, response.code
    end
  end

  def test_methods_fail_without_params
    setup
    VCR.use_cassette('make_item_with_no_params') do
      err = assert_raises ArgumentError do
        @client.new_item()
      end
      assert_equal "missing keywords: list_id, name", err.message
    end
  end

  # mark_item_finished
  def test_it_marks_an_item_finished
    setup
    VCR.use_cassette('mark_item_finished') do
      item = @client.new_item(list_id: @list['id'], name: 'Call mom')
      response = @client.finish_item(list_id: @list['id'], item_id: item['id'])
      assert_equal 200, response.code
    end
  end

  def test_mark_item_finished_returns_an_error_code
    setup
    VCR.use_cassette('mark_item_finished_error_code') do
      item = @client.new_item(list_id: @list['id'], name: 'Call dad')
      @client.finish_item(list_id: @list['id'], item_id: item['id'])
      response = @client.finish_item(list_id: @list['id'], item_id: item['id'])
      assert_equal 404, response.code
    end
  end

  def test_it_deletes_an_item
    setup
    VCR.use_cassette('delete_an_item') do
      item = @client.new_item(list_id: @list['id'], name: 'Lame todootle doot')
      response = @client.delete_item(list_id: @list['id'], item_id: item['id'])
      assert_equal 204, response.code
    end
  end

  def test_it_gives_an_error_if_it_cant_find_item_to_delete
    setup
    VCR.use_cassette('delete_an_item_psych') do
      item = @client.new_item(list_id: @list['id'], name: 'Lame todootle doot')
      response = @client.delete_item(list_id: @list['id'], item_id: 3)
      assert_equal 404, response.code
    end
  end
end