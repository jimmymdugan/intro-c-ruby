require_relative 'rectangle'
require_relative 'point'
require 'test/unit'

class FactorialTest < Test::Unit::TestCase 

  def test_width
    rect = Rectangle.new(Point.new(0, 0), Point.new(2, 2))
    assert_equal 2, rect.width, "(0,0),(2,2) width should be 2"
  end  

  def test_height
    rect = Rectangle.new(Point.new(0, 0), Point.new(2, 2))
    assert_equal 2, rect.height, "(0,0),(2,2) height should be 2"
  end

  def test_perimeter
    rect = Rectangle.new(Point.new(0, 0), Point.new(2, 2))
    assert_equal 8, rect.perimeter, "(0,0),(2,2) perimeter should be 8"
  end

  def test_area
    rect = Rectangle.new(Point.new(0, 0), Point.new(2, 2))
    assert_equal 4, rect.area, "(0,0),(2,2) area should be 4"
  end
end
