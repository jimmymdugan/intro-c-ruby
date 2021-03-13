require_relative 'circle'
require_relative 'point'
require 'test/unit'   

class FactorialTest < Test::Unit::TestCase 

  def test_diameter
    circle = Circle.new(Point.new(0, 0), Point.new(0, 2))
    assert_equal 4, circle.diameter, "(0,0),(0,2) diameter should be 4"
  end  

  def test_circumference
    circle = Circle.new(Point.new(0, 0), Point.new(0, 2))
    assert_equal Math::PI * 4, circle.circumference, "(0,0),(0,2) circumference should be pi * 4"
  end

  def test_area
    circle = Circle.new(Point.new(0, 0), Point.new(0, 2))
    assert_equal Math::PI * 4, circle.area, "(0,0),(0,2) area should be pi * 4"
  end
end
