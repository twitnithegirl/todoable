require_relative '../test_helper'

class TodoableListTest < Minitest::Test
  def test_exists
    assert Todoable::List
  end

  def test_it_gives_back_a_single_list
    VCR.use_cassette('one_list') do
      list = Todoable::List.find(1)
      assert_equal Todoable::List, list.class

      assert_equal "List Name", list.name
      assert_equal "Item 1 name", list.items[1].name
      assert_equal "Item 2 name", list.items[2].name
    end
  end
end