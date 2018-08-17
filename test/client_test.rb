# frozen_string_literal: true

require_relative './test_helper'

class TodoableClientTest < Minitest::Test
  def test_creates_a_client_when_you_pass_in_username_and_password
    VCR.use_cassette('valid') do
      client = Todoable::Client.new(username: 'britnialexander@gmail.com',
                                    password: 'todoable')
      assert_equal Todoable::Client, client.class
      assert_equal 'britnialexander@gmail.com', client.username
      assert_equal 'todoable', client.password
    end
  end

  def test_does_not_create_client_when_username_missing
    VCR.use_cassette('no_user') do
      err = assert_raises Todoable::Errors do
        Todoable::Client.new(password: 'todoable')
      end
      assert_equal [':username is a required parameter'], JSON.parse(err.message)
    end
  end

  def test_does_not_create_client_when_password_missing
    VCR.use_cassette('no_pw') do
      err = assert_raises Todoable::Errors do
        Todoable::Client.new(username: 'britnialexander@gmail.com')
      end
      assert_equal [':password is a required parameter'], JSON.parse(err.message)
    end
  end

  def test_does_not_create_client_with_invalid_credentials
    VCR.use_cassette('invalid_creds') do
      err = assert_raises Todoable::Errors do
        Todoable::Client.new(username: 'barney',
                             password: 'wasadinosaur')
      end
      assert_equal ['invalid :username and :password combination'], JSON.parse(err.message)
    end
  end
end