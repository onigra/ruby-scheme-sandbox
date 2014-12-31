require_relative '../test_helper'

class SchemeRTest < Test::Unit::TestCase
  setup do
    @obj = SchemeR.new
  end

  def test_eval
    assert_equal 3, @obj._eval([:+, 1, 2])
  end
end
