def calculate(operand1, operand2, operator)
  case operator
  when '+'
    operand1 + operand2
  when '-'
    operand1 - operand2
  when '*'
    operand1 * operand2
  when '/'
    return 'Error: Division by zero' if operand2 == 0

    operand1.to_f / operand2
  else
    'Error: Invalid operator'
  end
end

puts 'Welcome to the Ruby Calculator!'

while true

  print 'Enter the first number: '
  num1 = gets.chomp.to_f

  print 'Enter the second number: '
  num2 = gets.chomp.to_f

  print 'Enter the operator : '
  op = gets.chomp

  result = calculate(num1, num2, op)

  puts "Result: #{result}"

  puts 'Would you like to perform another calculation? (y/n)'

  choice = gets.chomp.downcase

  break if choice != 'y'
end

puts 'Thank you for using the calculator.'
