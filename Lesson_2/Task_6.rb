cart = {}
sum = 0

loop do 
  puts "Введите название товара, цену и количество."

  product = gets.chomp

  break if product == "стоп"

  price = gets.chomp.to_f
  count = gets.chomp.to_f

  

  if cart.include?(product)
    puts "Товар #{product} уже есть в корзине."
  else
    if cart.nil?
      cart = {product => {prices: price, count: count}}
    else 
      cart[product] = {prices: price, count: count}
    end
  end
end

cart.each do |product, prices|
  total = prices[:prices]*prices[:count]
  puts "Товар: #{product} Цена: #{prices[:prices]} Количество: #{prices[:count]} Итог: #{total}." 
  sum += total
end

puts "Общая сумма: #{sum}."