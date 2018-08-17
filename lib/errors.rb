module Todoable
  class Errors < StandardError
    def initialize(errors)
      super
      errors
    end
  end
end