print 'Введите 3 коэффициента a,b,c:'
a = gets.chomp.to_i
b = gets.chomp.to_i
c = gets.chomp.to_i

d = b**2 - 4*a*c
print "Дискриминант: #{d}. "

radical_d = Math.sqrt(d)

if d > 0
  x1 = (-b + radical_d) / (2*a)
  x2 = (-b - radical_d) / (2*a)
  puts "Два различных корня. Х1=#{x1}, х2=#{x2}!"
elsif d == 0
  x = -b / (2*a)
  puts "Единственный корень. Х = #{x}!"
else 
  puts 'Корней нет!'
end