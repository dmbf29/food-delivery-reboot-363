require_relative 'base_view'

class MealsView < BaseView
  def display(meals) # array of meal instances
    if meals.empty?
      puts "No meals yet. 🍽"
    else
      meals.each do |meal|
        puts "#{meal.id}.) #{meal.name} - $#{meal.price}"
      end
    end
  end
end
