require_relative 'train'

class PassengerTrain < Train
  def initialize(number)
    super
    @type = 'Пассажирский'
  end

  def add_wagon(wagon)
    raise 'В пассажирском поезде могут быть только пассажирские вагоны.' unless wagon.is_a? PassengerWagon
    super
  end
end
