require('pg')
require_relative("../db/sql_runner")

class PizzaOrder

  attr_accessor :topping, :quantity
  attr_reader :id, :customer_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @topping = options['topping']
    @quantity = options['quantity'].to_i()
    @customer_id = options['customer_id'].to_i()
  end

  def save()
    sql = "INSERT INTO pizza_orders
    (
      topping,
      quantity,
      customer_id
    ) VALUES
    (
      $1, $2, $3
    )
    RETURNING id"
    values = [@topping, @quantity, @customer_id]

    results = SqlRunner.run(sql, values)

    @id = results[0]["id"].to_i
  end

  def update()
    sql = "
    UPDATE pizza_orders SET (
      topping,
      quantity,
      customer_id
    ) =
    (
      $1,$2, $3
    )
    WHERE id = $4"
    values = [@topping, @quantity, @customer_id, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM pizza_orders where id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.find(id)
    sql = "SELECT * FROM pizza_orders WHERE id = $1"
    values = [id]
    results = SqlRunner.run(sql, values)
    order_hash = results.first()
    order = PizzaOrder.new(order_hash)
    return order
  end

  def self.delete_all()
    sql = "DELETE FROM pizza_orders"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM pizza_orders"
    orders = SqlRunner.run(sql)
    return orders.map { |order| PizzaOrder.new(order) }
  end

  def customer()
    sql = "SELECT * FROM customers WHERE id = $1"
    values = [@customer_id]
    results = SqlRunner.run(sql, values)
    return Customer.new(results[0])
  end

end
