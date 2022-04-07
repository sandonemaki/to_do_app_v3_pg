class PresenterEdit
  attr_reader :content, :errors, :id

  def initialize(content:, errors: {}, id:)
    @content = content
    @errors = errors
    @id = id
  end
end
