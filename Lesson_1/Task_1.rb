puts 'Как вас зовут?'
name = gets.chomp
name.capitalize!

puts 'Ваш рост?'
weight = gets.chomp.to_i

ideal_weight = weight - 110

if ideal_weight >= 0 
  puts "#{name}, ваш оптимальный вес #{ideal_weight}!"
else 
  puts "Ваш вес уже оптимальный!"
end