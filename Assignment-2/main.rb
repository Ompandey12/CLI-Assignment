require_relative 'inventory'
require_relative 'order'

OWNER_PASSWORD = 'secret123'

class UserDashboard
  def initialize
    @inventory = Inventory.new
    @order = Order.new
  end

  def main_menu
    loop do
      puts "\nSelect role:"
      puts '1. Warehouse Owner'
      puts '2. Customer'
      puts '3. Exit'
      print 'Choice: '
      choice = gets.chomp.to_i

      case choice
      when 1
        owner_login
      when 2
        customer_menu
      when 3
        puts 'Bye!'
        break
      else
        puts 'Invalid choice.'
      end
    end
  end

  private

  def owner_login
    attempts = 3
    while attempts > 0
      print 'Enter owner password: '
      input = gets.chomp
      if input == OWNER_PASSWORD
        owner_menu
        return
      else
        attempts -= 1
        puts "Wrong password. Attempts left: #{attempts}"
      end
    end
    puts 'Failed login attempts.'
  end

  def owner_menu
    loop do
      puts "\nOwner Menu:"
      puts '1. List Products'
      puts '2. Search Products'
      puts '3. Add Product'
      puts '4. Update Product'
      puts '5. Delete Product'
      puts '6. View Orders'
      puts '7. Logout'
      print 'Select: '
      choice = gets.chomp.to_i

      case choice
      when 1
        @inventory.list_all
      when 2
        print 'Keyword: '
        kw = gets.chomp
        @inventory.search(kw)
      when 3
        @inventory.add_product
      when 4
        @inventory.update_product
      when 5
        print 'ID to delete: '
        id = gets.chomp
        if @inventory.delete_product(id)
          puts 'Deleted.'
        else
          puts 'Not found.'
        end
      when 6
        @order.show_orders
      when 7
        puts 'Logging out...'
        break
      else
        puts 'Invalid choice.'
      end
    end
  end

  def customer_menu
    loop do
      puts "\nCustomer Menu:"
      puts '1. List Products'
      puts '2. Search Products'
      puts '3. Place Order'
      puts '4. View Order Summaries'
      puts '5. Back'
      print 'Select: '
      choice = gets.chomp.to_i

      case choice
      when 1
        @inventory.list_all
      when 2
        print 'Keyword: '
        kw = gets.chomp
        @inventory.search(kw)
      when 3
        print 'Product ID to order: '
        pid = gets.chomp
        if @inventory.product_exists?(pid)
          @order.place_order(pid)
        else
          puts 'Product not found.'
        end
      when 4
        @order.show_order_summaries
      when 5
        puts 'Going back...'
        break
      else
        puts 'Invalid.'
      end
    end
  end
end

UserDashboard.new.main_menu
