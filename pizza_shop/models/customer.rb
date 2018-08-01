require('pg')
require_relative("../db/sql_runner")

class Customer
  attr_reader :id
  attr_accessor :first_name, :last_name

  def initialize(options)
    @id = options['id'].to_i() if options['id']
    @first_name = options['first_name']
    @last_name = options['last_name']
  end

  def save()
    sql = "INSERT INTO customers (first_name, last_name)
          VALUES ($1, $2) RETURNING id"
    values = [@first_name, @last_name]
    results = SqlRunner.run(sql, values)
    @id = results[0]['id'].to_i()
  end

  def self.delete_all()
    sql = "DELETE FROM customers"
    results = SqlRunner.run(sql)
  end

  def orders()
    sql = "SELECT * FROM pizza_orders WHERE customer_id = $1"
    values = [@id]
    results = SqlRunner.run(sql, values)
    return results.map {|order| PizzaOrder.new(order)}
  end

end
