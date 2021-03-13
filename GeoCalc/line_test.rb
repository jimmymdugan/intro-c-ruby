require_relative 'line'
require_relative 'point'
require 'test/unit'     

class FactorialTest < Test::Unit::TestCase 

  def test_lr # test line left, right, horizontal
    line = Line.new(Point.new(0, 0), Point.new(0, 2))
    assert_equal 2, line.length,"(0,0), (0,2) length should be 2"
  end

  def test_rl # test line right, left, horizontal
    line = Line.new(Point.new(0, 2), Point.new(0, 0))
    assert_equal 2, line.length, "(0,2), (0,0) length should be 2"
  end

  def test_du # test line down, up, vertical
    line = Line.new(Point.new(0, 0), Point.new(2, 0))
    assert_equal 2, line.length, "(0,0), (2,0) length should be 2"
  end

  def test_ud # test line up, down, vertical
    line = Line.new(Point.new(2, 0), Point.new(0, 0))
    assert_equal 2, line.length, "(2,0), (0,0) length should be 2"
  end

  def test_diag # test diag
    line = Line.new(Point.new(0, 0), Point.new(2, 2))
    assert_equal Math.sqrt(8), line.length, "(0, 0), (2, 2) length should be sqrt(8)"
  end
end
