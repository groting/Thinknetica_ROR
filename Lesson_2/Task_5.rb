puts "Введите число, месяц и год."

months = {Jan: 31, Feb: 28, Mar: 31, Apr: 30, May: 31, Jun: 30, Jul: 31, Aug: 31, Sep: 30, Okt: 31, Nov: 30, Dec: 31}

day = gets.chomp.to_i
month = gets.chomp.to_i
year = gets.chomp.to_i

num = day
months = months.each_value.to_a


for i in 1...month do
  num += months[i]
end

num += 1 if (year % 4 == 0 && year % 100 != 0) || year % 400 == 0

puts "Порядковый номер дня: #{num}!"