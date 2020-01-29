require_relative 'base_view'

class OrdersView < BaseView
  def display(orders) # array of customer instances
    if orders.empty?
      puts "No orders yet. 🤷‍♀️"
    else
      orders.each do |order|
        puts "#{order.id}: #{order.customer.name} - #{order.customer.address}\n
        #{order.meal.name} - $#{order.meal.price}\n
        Driver: #{order.employee.username}"
      end
    end
  end

  def display_employees(drivers)
    if drivers.empty?
      puts "No drivers yet. 🚚"
    else
      drivers.each do |driver|
        puts "#{driver.id} - #{driver.username}"
      end
    end
  end
end
