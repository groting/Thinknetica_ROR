puts "Введите число, месяц и год."

months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

day = gets.chomp.to_i
month = gets.chomp.to_i
year = gets.chomp.to_i

num = day

for i in 0...month-1 do
  num += months[i]
end

num += 1 if ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0) && month > 2

puts "Порядковый номер дня: #{num}!"