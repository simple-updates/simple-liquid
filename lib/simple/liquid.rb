require 'liquid'

module Simple
end

class Simple::Liquid
  class Error < RuntimeError
  end

  VERSION = '1.1.0'

  attr_reader :template, :object, :filters

  def initialize(template, object = {}, filters = [])
    @template = template
    @object = deep_stringify_keys(object.to_h)
    @filters = filters
  end

  def self.render(template, object = {}, filters = [])
    new(template, object, filters).render
  end

  def liquid_template
    @liquid_template ||= ::Liquid::Template.parse(template, error_mode: :strict)
  end

  def render
    liquid_template.render(
      object,
      strict_variables: true,
      strict_filters: true,
      filters: filters
    ).tap { raise_if_errors! }
  end

  def raise_if_errors!
    errors = liquid_template.errors
    return if errors.empty?
    messages = errors.map { |error| error.message.gsub('Liquid error:', '').strip }
    raise Simple::Liquid::Error.new(messages.join(', '))
  end

  private

  def deep_stringify_keys(object)
    if object.is_a?(Array)
      object.map { |value| deep_stringify_keys(value) }
    elsif object.is_a?(Hash)
      object.transform_keys(&:to_s).transform_values do |value|
        deep_stringify_keys(value)
      end
    else
      object
    end
  end
end
