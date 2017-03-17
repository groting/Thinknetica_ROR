require_relative 'wagon'

class PassengerWagon < Wagon

  def info
    return "Тип: Пассажирский Занятые места: #{occupied} Свободные места: #{free_space}"
  end

  def occupy
    raise "Свободного места не осталось!" if free_space == 0
    self.free_space -=1
  end
end
