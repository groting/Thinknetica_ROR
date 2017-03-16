require_relative 'wagon'

class CargoWagon < Wagon

  def occupy(num)
    raise "Вы должны ввести число больше нуля!" if num.nil? || !num.kind_of?(Numeric) || num <= 0
    raise "Не хватит свободного места! Места осталось:#{free_space}!" if num > free_space
    self.free_space -= num
  end

end