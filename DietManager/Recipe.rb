require './BasicFood'

class Recipe
  attr_accessor :name, :ingredients, :calories

  #recipeName is the name of this recipe and ingredientsList is the list of BasicFood objects in this recipe
  def initialize(recipeName, ingredientsList)
    @name = recipeName
    @ingredients = ingredientsList.sort{|x, y| x.name <=> y.name} #Sorts the list by ingredient name
    @calories = get_calories

    #Calculate the total calories in this Recipe

  end

  def get_calories
    total_cal = 0
    @ingredients.each do |x|
      total_cal += x.calories.to_i
    end
    total_cal
  end


  #Returns a string representation of this Recipe formatted for printing
  def to_s
    str = "#{@name} #{@calories}\n"
    @ingredients.each do |food|
      str += "  #{food.name} #{food.calories}\n"
    end
    str
  end
end
