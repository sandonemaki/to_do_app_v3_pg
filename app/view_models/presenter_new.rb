class PresenterNew
  attr_reader :content, :errors

  def initialize(content:, errors: {})
    @content = content #String
    @errors = errors #Hash
  end
end
