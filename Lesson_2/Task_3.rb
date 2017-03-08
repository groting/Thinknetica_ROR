fib = [0,1]


loop do
  num = fib[-2].to_i + fib[-1].to_i

  break if num > 100
  
  fib.push(num)
end