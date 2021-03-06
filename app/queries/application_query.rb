# frozen_string_literal: true

class ApplicationQuery
  def initialize(scope = nil)
    @scope = scope || default
  end

  private

  attr_reader :scope

  def default
    model_class.all
  end

  def model_class
    self.class.name.demodulize.gsub('Query', '').constantize
  end
end
