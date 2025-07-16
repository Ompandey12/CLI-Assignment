ops_array = ['+', '-', '*', '/']

while true

  print 'Enter the first number: '
  num1 = gets.chomp.to_f

  print 'Enter the second number: '
  num2 = gets.chomp.to_f

  print 'Enter the operator : '
  op = gets.chomp
  if !ops_array.include?(op)
    puts 'Error: Invalid operator. Please use one of the following: +, -, *, /'
  else
    result = num1.send(op, num2)
    puts "Result: #{result}"
  end

  puts 'Would you like to perform another calculation? (y/n)'

  choice = gets.chomp.downcase

  break if choice != 'y'
end

puts 'Thank you for using the calculator.'
