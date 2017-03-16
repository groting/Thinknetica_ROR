require_relative 'train'

class PassengerTrain < Train

  def initialize(number)
    super
    @type = 'Пассажирский'
  end

  def add_wagon(wagon)
    raise 'В пассажирском поезде могут быть только пассажирские вагоны.' if !wagon.is_a? PassengerWagon
    super
  end
end
