print 'Введите 3 стороны треугольника:'
a = gets.chomp.to_i
b = gets.chomp.to_i
c = gets.chomp.to_i

if a == b || a == c || b == c
	print 'Треугольник равнобедренный. '
else print 'Треугольник не равнобедренный. '
end

if a == b && b == c
	print "Треугольник равностороний, что исключает возможность существования в нем прямого угла."
	abort
end

if a > b && a > c 
	hyp = a
	kat1 = b
	kat2 = c
elsif b > c
	hyp = b
	kat1 = a
	kat2 = c
else 
	hyp = c
	kat1 = a
	kat2 = b
end

if hyp**2 == kat1**2 + kat2**2
	print 'Треугольник прямоугольный!'
else print 'Треугольник не прямоугольный!'
end
