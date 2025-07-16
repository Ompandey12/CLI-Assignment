require_relative 'product'

class Inventory
  FILE = 'products.csv'

  def initialize
    return if File.exist?(FILE)

    File.write(FILE, "id,name,price,stock,company\n")
  end

  def list_all
    puts "\nAll Products:"
    lines = File.readlines(FILE)
    for i in 1...lines.length
      puts lines[i].strip
    end
  end

  def search(keyword)
    puts "\nSearch Results:"
    found = false
    lines = File.readlines(FILE)
    for i in 1...lines.length
      if lines[i].downcase.include?(keyword.downcase)
        puts lines[i].strip
        found = true
      end
    end
    puts 'No product found.' unless found
  end

  def add_product
    print 'Enter ID: '
    id = gets.chomp
    print 'Enter Name: '
    name = gets.chomp
    print 'Enter Price: '
    price = gets.chomp
    print 'Enter Stock: '
    stock = gets.chomp
    print 'Enter Company: '
    company = gets.chomp

    product = Product.new(id, name, price, stock, company)
    File.open(FILE, 'a') { |f| f.puts product.to_csv }
    puts 'Product added.'
  end

  def update_product
    print 'Enter product ID to update: '
    id = gets.chomp

    lines = File.readlines(FILE)
    updated = false

    for i in 1...lines.length
      next unless lines[i].start_with?(id + ',')

      product = Product.from_csv(lines[i])

      print "New name (#{product.name}): "
      name = gets.chomp
      product.name = name unless name.empty?

      print "New price (#{product.price}): "
      price = gets.chomp
      product.price = price unless price.empty?

      print "New stock (#{product.stock}): "
      stock = gets.chomp
      product.stock = stock unless stock.empty?

      print "New company (#{product.company}): "
      company = gets.chomp
      product.company = company unless company.empty?

      lines[i] = product.to_csv + "\n"
      updated = true
      break
    end

    if updated
      File.write(FILE, lines.join)
      puts 'Product updated.'
    else
      puts 'Product ID not found.'
    end
  end

  def product_exists?(id)
    lines = File.readlines(FILE)
    for i in 1...lines.length
      return true if lines[i].start_with?(id + ',')
    end
    false
  end

  def delete_product(id)
    lines = File.readlines(FILE)
    header = lines[0]
    new_lines = [header]
    deleted = false

    for i in 1...lines.length
      if !lines[i].start_with?(id + ',')
        new_lines.push(lines[i])
      else
        deleted = true
      end
    end

    File.write(FILE, new_lines.join) if deleted
    deleted
  end
end
