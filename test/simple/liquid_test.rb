require "minitest/autorun"
require_relative '../../lib/simple/liquid'

class TestSimpleLiquid < Minitest::Test
  extend MiniTest::Spec::DSL

  @@counter = 0

  def self.it(&block)
    @@counter += 1

    define_method("test_#{@@counter}", &block)
  end

  def assert_raises_message(message, &block)
    error = nil

    begin
      block.call
    rescue => e
      error = e
    end

    assert_includes(error&.message.to_s, message)
  end

  before do
    @template = '{{ a }} {{ b }} {{ c }}'
    @object = { a: 1, b: 2, c: 3 }
  end

  it { assert_equal("1 2 3", Simple::Liquid.render(@template, @object)) }
  it { assert_equal("a", Simple::Liquid.render("a", @object)) }

  it do
    assert_raises_message("undefined variable d") do
      Simple::Liquid.render("{{ d }}", @object)
    end
  end

  it do
    assert_raises_message("undefined variable d, undefined variable e") do
      Simple::Liquid.render("{{ d }} {{ e }}", @object)
    end
  end

  it do
    assert_raises(Simple::Liquid::Error) do
      Simple::Liquid.render("{{ d | oops }}", @object)
    end
  end

  it do
    module MyPlusFilter
      def my_plus(original, value)
        original.to_i + value.to_i
      end
    end

    assert_equal(
      "2",
      Simple::Liquid.render(
        "{{ a | my_plus: 1 }}",
        { a: 1 },
        [MyPlusFilter]
      )
    )
  end
end
