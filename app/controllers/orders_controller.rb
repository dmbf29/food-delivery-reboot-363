require_relative '../views/orders_view'

class OrdersController
  def initialize(meal_repository, employee_repository, customer_repository, order_repository)
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    @order_repository = order_repository
    @orders_view = OrdersView.new
  end

  def list_undelivered_orders
    # ask the repo for the undelivered orders
    orders = @order_repository.undelivered_orders
    # give order to the view
    @orders_view.display(orders)
  end

  def add
    # display meals
    MealsController.new(@meal_repository).list
    # @ ask the user for a meal_id
    meal_id = @orders_view.ask_for("meal number").to_i
    meal = @meal_repository.find(meal_id)
    # @ ask the user for a customer_id
    CustomersController.new(@customer_repository).list
    customer_id = @orders_view.ask_for("customer number").to_i
    customer = @customer_repository.find(customer_id)
    # @ ask the user for a employeed_id
    drivers = @employee_repository.delivery_guys
    @orders_view.display_employees(drivers)
    employee_id = @orders_view.ask_for("employee number").to_i
    employee = @employee_repository.find(employee_id)

    order = Order.new(
      meal: meal,
      customer: customer,
      employee: employee
    )
    @order_repository.add(order)
    # add to the repo
  end

  def list_my_orders(employee)
    # get order for the employee
    orders = @order_repository.undelivered_orders
    my_orders = orders.select { |order| order.employee == employee }
    @orders_view.display(my_orders)
  end

  def mark_as_delivered(employee)
    list_my_orders(employee)
    order_id = @orders_view.ask_for("order number that was delivered").to_i
    @order_repository.mark_as_delivered(order_id)
  end
end
