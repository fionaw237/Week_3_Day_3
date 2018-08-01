require('pg')

class Customer
  attr_reader :id
  attr_accessor :first_name, :last_name

  def initialize(options)
    @id = options['id'].to_i() if options['id']
    @first_name = options['first_name']
    @last_name = options['last_name']
  end

  def save()
    db = PG.connect({ dbname: 'pizza_shop', host: 'localhost' })
    sql = "INSERT INTO customers (first_name, last_name)
          VALUES ($1, $2) RETURNING id"
    values = [@first_name, @last_name]
    db.prepare("save", sql)
    results = db.exec_prepared("save", values)
    db.close()
    @id = results[0]['id'].to_i()
  end

  def self.delete_all()
    db = PG.connect({ dbname: 'pizza_shop', host: 'localhost' })
    sql = "DELETE FROM customers"
    db.prepare("delete_all", sql)
    db.exec_prepared("delete_all")
    db.close()
  end

  def orders()
    db = PG.connect({dbname: 'pizza_shop', host: 'localhost'})
    sql = "SELECT * FROM pizza_orders WHERE customer_id = $1"
    values = [@id]
    db.prepare("orders", sql)
    results = db.exec_prepared("orders", values)
    db.close()
    return results.map {|order| PizzaOrder.new(order)}
    return
  end

end
