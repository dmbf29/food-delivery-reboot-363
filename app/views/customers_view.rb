require_relative 'base_view'

class CustomersView < BaseView
  def display(customers) # array of customer instances
    if customers.empty?
      puts "No customers yet. 🤷‍♀️"
    else
      customers.each do |customer|
        puts "#{customer.id}.) #{customer.name} - #{customer.address}"
      end
    end
  end
end
