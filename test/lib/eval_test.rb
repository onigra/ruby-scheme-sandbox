require_relative '../test_helper'

class SchemeTest < Test::Unit::TestCase
  setup do
    @obj = Scheme.new
  end

  def test_eval1
    exp = [:+, 1, 2]
    assert_equal 3, @obj._eval(exp, $global_env)
  end

  def test_eval2
    exp = [:+, [:+, 1, 2], 3]
    assert_equal 6, @obj._eval(exp, $global_env)
  end

  def test_lambda1
    exp = [[:lambda, [:x, :y], [:+, :x, :y]], 3, 2]
    assert_equal 5, @obj._eval(exp, $global_env)
  end

  def test_lambda2
    exp = [[:lambda, [:x], [:+, [[:lambda, [:y], :y], 2], :x]], 1]
    assert_equal 3, @obj._eval(exp, $global_env)
  end

  def test_lambda3
    exp = [[:lambda, [:x], [:+, [[:lambda, [:x], :x], 2], :x]], 1]
    assert_equal 3, @obj._eval(exp, $global_env)
  end

  def test_let1
    exp = [:let, [[:x, 3], [:y, 2]], [:+, :x, :y]]
    assert_equal 5, @obj._eval(exp, $global_env)
  end

  def test_let2
    exp = [:let, [[:x, 3]],
             [:let, [[:fun, [:lambda, [:y], [:+, :x, :y]]]],
               [:+ , [:fun, 1], [:fun, 2]]]]
    assert_equal 9, @obj._eval(exp, $global_env)
  end

  def test_if
    exp = [:if, [:>, 3, 2], 1, 0]
    assert_equal 1, @obj._eval(exp, $global_env)
  end

  def test_letrec1
    exp = [:let,
            [[:fact,
              [:lambda, [:n], [:if, [:<, :n, 1], 1, [:*, :n, [:fact, [:-, :n, 1]]]]]]],
            [:fact, 0]]
    assert_equal 1, @obj._eval(exp, $global_env)
  end

  def test_letrec2
    exp = [:letrec,
            [[:fact,
              [:lambda, [:n], [:if, [:<, :n, 1], 1, [:*, :n, [:fact, [:-, :n, 1]]]]]]],
            [:fact, 1]]
    assert_equal 1, @obj._eval(exp, $global_env)
  end
end
