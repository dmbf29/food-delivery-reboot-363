require_relative '../views/customers_view'

class CustomersController
  def initialize(customer_repository)
    @customer_repository = customer_repository
    @customers_view = CustomersView.new
  end

  def list
    # get all the meals from the repo
    customers = @customer_repository.all
    # give them to the view
    @customers_view.display(customers)
  end

  def add
    # ask user for name
    name = @customers_view.ask_for('name')
    # ask user for price
    address = @customers_view.ask_for('address')
    # create an instance
    customer = Customer.new(name: name, address: address)
    # add to repository
    @customer_repository.add(customer)
  end
end
