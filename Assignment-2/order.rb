require_relative 'product'

class Order
  ORDER_FILE = 'orders.csv'
  SUMMARY_FILE = 'order_summary.csv'
  PRODUCT_FILE = 'products.csv'

  def initialize
    File.write(ORDER_FILE, "id,name,credit_no,cvv\n") unless File.exist?(ORDER_FILE)
    File.write(SUMMARY_FILE, "id,name,quantity,total_price\n") unless File.exist?(SUMMARY_FILE)
  end

  def place_order(product_id)
    lines = File.readlines(PRODUCT_FILE)
    header = lines.shift
    product = nil

    for line in lines
      if line.start_with?(product_id + ',')
        product = Product.from_csv(line)
        break
      end
    end

    return puts 'Product not found.' unless product

    puts "Product selected: #{product.name} - ₹#{product.price} each"
    print 'Quantity to order: '
    quantity = gets.chomp.to_i

    return puts 'Invalid quantity.' if quantity <= 0
    return puts "Insufficient stock. Available: #{product.stock}" if quantity > product.stock.to_i

    total_price = product.price.to_i * quantity
    puts "Total amount: ₹#{total_price}"

    print 'Your name: '
    name = gets.chomp
    print 'Credit card number: '
    credit_no = gets.chomp
    print 'CVV: '
    cvv = gets.chomp

    save_order(product_id, name, credit_no, cvv)
    save_summary(product_id, name, quantity, total_price)
    update_stock(product, quantity, lines, header)

    puts 'Order placed successfully!'
  end

  def show_orders
    puts "\nOrders:"
    lines = File.readlines(ORDER_FILE)
    for i in 1...lines.length
      puts lines[i].strip
    end
  end

  def show_order_summaries
    puts "\nOrder Summaries:"
    lines = File.readlines(SUMMARY_FILE)
    for i in 1...lines.length
      puts lines[i].strip
    end
  end

  private

  def save_order(product_id, name, credit_no, cvv)
    File.open(ORDER_FILE, 'a') do |file|
      file.puts "#{product_id},#{name},#{credit_no},#{cvv}"
    end
  end

  def save_summary(product_id, name, quantity, total_price)
    File.open(SUMMARY_FILE, 'a') do |file|
      file.puts "#{product_id},#{name},#{quantity},#{total_price}"
    end
  end

  def update_stock(product, quantity, lines, header)
    product.stock = (product.stock.to_i - quantity).to_s
    new_content = header
    for line in lines
      new_content += if line.start_with?(product.id + ',')
                       product.to_csv + "\n"
                     else
                       line
                     end
    end
    File.write(PRODUCT_FILE, new_content)
  end
end
