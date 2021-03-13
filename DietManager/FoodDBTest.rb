require 'minitest/autorun'          #We need Ruby's unit testing library
require './FoodDB'

class FoodDBTest < MiniTest::Test
  def setup							#setup method is run automatically before each test_xxx
    @fdb = FoodDB.new("FoodDB.txt")
  end

  #Tests if there are entries in the DB after FoodDB.txt is read
  def test_DB_initialization
    assert(@fdb.size > 0, "Database entries not correctly read in")
  end

  #Tests the 'contains_food?' method of FoodDB
  def test_contains_food
    assert_equal(true, @fdb.contains_food?("Orange"), " Orange Basic Food contains_food? is not correct")
    assert_equal(true, @fdb.contains_food?("Apple"), "Apple Basic Food contains_food? is not correct")
    assert_equal(true, @fdb.contains_food?("Peanut Butter"), " Peanut Butter Basic Food contains_food? is not correct")
    assert_equal(true, @fdb.contains_food?("Jelly"), "Jelly Basic Food contains_food? is not correct")
    assert_equal(true, @fdb.contains_food?("Bread Slice"), "Bread Slice Basic Food contains_food? is not correct")
    assert_equal(false, @fdb.contains_food?("Ham"), "Ham Basic Food contains_food? is not correct")
    assert_equal(false, @fdb.contains_food?("Chipotle"), "Chipotle Basic Food contains_food? is not correct")

  end

  #Tests the 'contains_recipe?' method of FoodDB
  def test_contains_recipe
    assert_equal(true, @fdb.contains_recipe?('Chicken Sandwich'))
    assert_equal(false, @fdb.contains_recipe?('sausage and egg'))
    assert_equal(true, @fdb.contains_recipe?('PB&J Sandwich'))
    assert_equal(false, @fdb.contains_recipe?('salsa'))
    assert_equal(false, @fdb.contains_recipe?('Chipotle'))
  end

  #Tests the 'contains?' method of FoodDB
  def test_contains
    assert_equal(true, @fdb.contains?('PB&J Sandwich'))
    assert_equal(true, @fdb.contains?('Chicken Sandwich'))
    assert_equal(false, @fdb.contains?('milk'))
    assert_equal(true, @fdb.contains?('Apple'))
    assert_equal(false, @fdb.contains?('McDanks'))
    assert_equal(true, @fdb.contains?('Chicken'))
    assert_equal(false, @fdb.contains?('Jam'))
    assert_equal(false, @fdb.contains?('Chipotle'))
    assert_equal(true, @fdb.contains?('Orange'))
    assert_equal(true, @fdb.contains?('Bread Slice'))

  end

  #Tests the 'get_food' method of FoodDB
  def test_get_food
    assert_equal(50, @fdb.get_food('Apple').calories)
    assert_equal('Chicken 245', @fdb.get_food('Chicken').to_s)
    assert_equal('Jelly 155', @fdb.get_food('Jelly').to_s)
  end

  #Tests the 'get_recipe' method of FoodDB
  def test_get_recipe
    assert_equal('Chicken Sandwich', @fdb.get_recipe('Chicken Sandwich').name)
    assert_equal('PB&J Sandwich', @fdb.get_recipe('PB&J Sandwich').name)
  end

  #Tests the 'get' method of FoodDB
  def test_get
    assert_equal('Apple 50', @fdb.get('Apple').to_s)
    assert_equal('Chicken 245', @fdb.get('Chicken').to_s)
    assert_equal('Jelly 155', @fdb.get('Jelly').to_s)
    assert_equal(405, @fdb.get('Chicken Sandwich').calories)
    assert_equal(490, @fdb.get('PB&J Sandwich').calories)
  end

  #Tests the 'find_matches' method of FoodDB
  def test_find_matches
    assert_equal(1, @fdb.find_matches('App').length)
    assert_equal(2, @fdb.find_matches('C').length)
    assert_equal(2, @fdb.find_matches('P').length)
    assert_equal(1, @fdb.find_matches('W').length)
    assert_equal(1, @fdb.find_matches('O').length)
    assert_equal(1, @fdb.find_matches('Ora').length)

  end

  #Tests the 'add_basicFood' method
  def test_add_food
    assert_equal(true, @fdb.add_basicFood("Water", 0))
    assert_equal(false, @fdb.add_basicFood("Water", 0))
    assert_equal(true, @fdb.add_basicFood("Rice", 100))
    assert_equal(false, @fdb.add_basicFood("Rice", 100))
    assert_equal(true, @fdb.add_basicFood("Beans", 100))
    assert_equal(false, @fdb.add_basicFood("Beans", 100))
    assert_equal(true, @fdb.add_basicFood("Steak", 100))
    assert_equal(false, @fdb.add_basicFood("Steak", 100))
    assert_equal(true, @fdb.add_basicFood("Sauce", 50))
    assert_equal(false, @fdb.add_basicFood("Sauce", 50))
    assert_equal(true, @fdb.add_basicFood("Cheese", 100))
    assert_equal(false, @fdb.add_basicFood("Cheese", 100))
    assert_equal(false, @fdb.add_basicFood("Orange", 67))
    assert_equal(false, @fdb.add_basicFood("Bread Slice", 80))
    assert_equal(false, @fdb.add_basicFood("Peanut Butter", 175))
    assert_equal(false, @fdb.add_basicFood("Jelly", 155))

  end

  #Tests the 'add_recipe' method
  def test_add_recipe
    assert_equal(true, @fdb.add_recipe('Rice and Beans', %w[Rice Water]))
    assert_equal(false, @fdb.add_recipe('Rice and Beans', %w[Rice Water]))
    assert_equal(true, @fdb.add_recipe('Chipotle', %w[Rice Beans Steak Sauce Cheese]))
    assert_equal(false, @fdb.add_recipe('Chipotle', %w[Rice Beans Steak Sauce Cheese]))
    assert_equal(false, @fdb.add_recipe('Chicken Sandwich', %w[Bread Slice Bread Slice Chicken]))
    assert_equal(false, @fdb.add_recipe('PB&J Sandwich', %w[Bread Slice Bread Slice Jelly Peanut Butter]))

  end

  #Tests the addition of a Recipe with a Recipe as one of its ingredients
  def test_recipe_within_recipe
    assert_equal(true, @fdb.add_recipe('Rice and Beans', %w[Rice Water]))
  end
end
