class Order
  attr_accessor :id
  attr_reader :meal, :customer, :employee

  def initialize(attributes = {})
    @id = attributes[:id] # integer
    @delivered = attributes[:delivered] || false # boolean
    @meal = attributes[:meal] # instance of a meal
    @customer = attributes[:customer] # instance of a customer
    @employee = attributes[:employee] # instance of a employee
  end

  def delivered?
    @delivered
  end

  def deliver!
    @delivered = true
  end
end
