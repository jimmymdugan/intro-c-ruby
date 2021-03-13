require 'minitest/autorun'          #We need Ruby's unit testing library
require_relative 'Recipe'

class RecipeTest < MiniTest::Test
  def setup
    @bread = BasicFood.new("Bread Slice", 80)
    @pb = BasicFood.new("Peanut Butter", 175)
    @jelly = BasicFood.new("Jelly", 155)
    @recipe = Recipe.new("PB&J Sandwich", [@bread, @pb, @jelly, @bread])
  end


  #Tests the initial construction of a Recipe
  def test_construction

    assert(@bread.name.eql?("Bread Slice"), "Name field was not initialized correctly")
    assert(@bread.calories == 80, "Calories field was not initialized correctly")
    assert(@pb.name.eql?("Peanut Butter"), "Name field was not initialized correctly")
    assert(@pb.calories == 175, "Calories field was not initialized correctly")
    assert(@jelly.name.eql?("Jelly"), "Name field was not initialized correctly")
    assert(@jelly.calories == 155, "Calories field was not initialized correctly")
    assert(@recipe.name.eql?("PB&J Sandwich"), "Name field was not initialized correctly")
    assert(@recipe.ingredients == [@bread, @bread, @jelly, @pb], "Calories field was not initialized correctly")

  end

  #Tests the 'to_s' method of Recipe
  def test_to_s
    assert_equal("PB&J Sandwich 490\n  Bread Slice 80\n  Bread Slice 80\n  Jelly 155\n  Peanut Butter 175\n", @recipe.to_s, "Failed Test for to String")

  end

end
