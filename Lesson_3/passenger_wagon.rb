require_relative 'wagon'

class PassengerWagon < Wagon
  include Validation

  validate('capacity', 'type', Numeric) 
  def info
    "Тип: Пассажирский Занятые места: #{occupied} Свободные места: #{free_space}"
  end

  def occupy
    raise 'Свободного места не осталось!' if free_space.zero?
    self.free_space -= 1
  end
end
