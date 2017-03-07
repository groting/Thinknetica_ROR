print 'Как вас зовут?'
name = gets.chomp
name.capitalize!

print 'Ваш рост?'
weight = gets.chomp

ideal_weight = weight.to_i - 110

if ideal_weight >= 0 
	print "#{name}, ваш оптимальный вес #{ideal_weight}!"
else print "Ваш вес уже оптимальный!"
end