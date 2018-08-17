module Todoable

  class Client
    attr_accessor :token, :username, :password, :api_url

    def initialize(username: nil, password: nil)
      @username = username
      @password = password
      @api_url  = API_URL

      validate_inputs
      authenticate
    end

    def get_or_refresh_token
      options = {
          basic_auth: { username: @username, password: @password },
          headers: {
              'Content-Type' => 'application/json',
              'Accept'       => 'application/json'
          }
      }
      @token = HTTParty.post("#{API_URL}/authenticate", options)

      unless @token['token']
        raise Todoable::Errors.new(['invalid :username and :password combination'])
      end
    end

    private

    def valid_token?
      return false unless @token
      Time.parse(@token['expires_at']) > Time.now
    end

    def validate_inputs
      errors = []
      errors.push ':password is a required parameter' if @password.nil?
      errors.push ':username is a required parameter' if @username.nil?
      raise Todoable::Errors.new(errors) unless errors.empty?
    end

    def authenticate
      get_or_refresh_token unless valid_token?
    end
  end
end