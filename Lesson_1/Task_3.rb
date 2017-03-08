print 'Введите 3 стороны треугольника:'
a = gets.chomp.to_f
b = gets.chomp.to_f
c = gets.chomp.to_f

if a == b || a == c || b == c
  print 'Треугольник равнобедренный. '
else 
  print 'Треугольник не равнобедренный. '
end

if a == b && b == c
  puts "Треугольник равностороний, что исключает возможность существования в нем прямого угла."
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
  puts 'Треугольник прямоугольный!'
else 
  puts 'Треугольник не прямоугольный!'
end
