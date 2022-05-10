# frozen_string_literal: true

class ApplicationUseCase
  def self.call(*args, &)
    new(*args, &).call
  end

  private

  def response(success: false, payload: {}, error: nil)
    OpenStruct.new(success?: success, payload:, error:)
  end
end
