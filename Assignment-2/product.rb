class Product
  attr_accessor :id, :name, :price, :stock, :company

  def initialize(id, name, price, stock, company)
    @id = id
    @name = name
    @price = price
    @stock = stock
    @company = company
  end

  def to_csv
    [@id, @name, @price, @stock, @company].join(',')
  end

  def self.from_csv(line)
    id, name, price, stock, company = line.strip.split(',')
    Product.new(id, name, price, stock, company)
  end
end
