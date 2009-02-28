$:.unshift File.join(File.dirname(__FILE__), "..", "lib")
require 'test/unit'
require 'perceptron'

class TestPerceptron < Test::Unit::TestCase

  def test_threshold
    assert_equal(1, AI::Perceptron.threshold(3))
    assert_equal(0, AI::Perceptron.threshold(0))
  end

  def test_net
    number = AI::NetworkNumber.new([1, 1], 1)
    weights = [-2, -3]
    assert_equal(-5, AI::Perceptron.net(weights, number))
  end

  def test_train
    @perceptron = AI::Perceptron.new(1, [-4, -3])
    @perceptron.train
    assert_equal(false, @perceptron.trained?)
    assert_equal([-2, -1], @perceptron.weights)

    @perceptron = AI::Perceptron.new(1, [0, 0])
    @perceptron.train
    assert_equal(true, @perceptron.trained?)
    assert_equal([1, 1], @perceptron.weights)

    @perceptron = AI::Perceptron.new(2, [-1, -2])
    @perceptron.train
    assert_equal(true, @perceptron.trained?)
    assert_equal([1, 1], @perceptron.weights)
  end

  def test_trained?
    @perceptron = AI::Perceptron.new(10, [-1, -1])
    assert_equal(false, @perceptron.trained?)
    @perceptron = AI::Perceptron.new(10, [1, 1])
    assert_equal(true, @perceptron.trained?)
  end

end
