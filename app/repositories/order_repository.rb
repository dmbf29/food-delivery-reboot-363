require 'csv'
require_relative '../models/order'

class OrderRepository
  def initialize(csv_file_path, meal_repository,employee_repository, customer_repository)
    @csv_file_path = csv_file_path
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    @orders = []
    @next_id = 1
    load_csv if File.exist?(@csv_file_path)
  end

  def undelivered_orders
    @orders.reject { |order| order.delivered? }
  end

  def add(order)
    order.id = @next_id
    @orders << order
    @next_id += 1
    save_csv
  end

  def mark_as_delivered(id)
    # find an order
    order = @orders.find { |order| order.id == id }
    # mark it as deliver!
    order.deliver!
    # save to csv
    save_csv
  end

  private

  def load_csv
    csv_options = { headers: :first_row, header_converters: :symbol }
    CSV.foreach(@csv_file_path, csv_options) do |attributes|
      attributes[:id] = attributes[:id].to_i
      attributes[:meal] = @meal_repository.find(attributes[:meal_id].to_i)
      attributes[:customer] = @customer_repository.find(attributes[:customer_id].to_i)
      attributes[:employee] = @employee_repository.find(attributes[:employee_id].to_i)
      attributes[:delivered] = attributes[:delivered] == 'true'
      @orders << Order.new(attributes)
    end
    @next_id = @orders.empty? ? 1 : @orders.last.id + 1
  end

  def save_csv
    CSV.open(@csv_file_path, 'wb') do |csv|
      csv << ['id', 'delivered', 'meal_id', 'customer_id', 'employee_id']
      @orders.each do |order|
        csv << [order.id, order.delivered?, order.meal.id, order.customer.id, order.employee.id]
      end
    end
  end
end
