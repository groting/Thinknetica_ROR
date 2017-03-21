require_relative 'wagon'

class CargoWagon < Wagon
  include Validation

  validate('capacity', 'type', Numeric) 
  def info
    "Тип: Грузовой Занятый объем: #{occupied} Свободный объем: #{free_space}"
  end

  def occupy(num)
    raise 'Вы должны ввести число больше нуля!' if !num.is_a?(Numeric) || num <= 0
    raise "Не хватит свободного места! Места осталось:#{free_space}!" if num > free_space
    self.free_space -= num
  end
end
