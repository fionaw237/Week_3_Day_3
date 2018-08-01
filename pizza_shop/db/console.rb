require("pry")
require_relative("../models/pizza_order")
require_relative("../models/customer")

PizzaOrder.delete_all()
Customer.delete_all()

customer1 = Customer.new(
  {
    'first_name' => 'Jack',
    'last_name' => 'Jarvis'
  }
)

customer1.save()

order1 = PizzaOrder.new(
  {
    'topping' => 'pepperoni',
    'quantity' => 2,
    'customer_id' => customer1.id()
  }
)

order1.save()

order2 = PizzaOrder.new(
  {
    'quantity' => 3,
    'topping' => 'Meat Feast',
    'customer_id' => customer1.id()
  }
)

order2.save()

binding.pry
nil
