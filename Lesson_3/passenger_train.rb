require_relative 'train'

class Passenger_train < Train

  def initialize(number)
    super
    @type = 'Passenger train'
  end

  def Passenger_wagon?(wagon)
    wagon.type == 'Passenger wagon'
  end

  def add_wagon(wagon)
    if Passenger_wagon?(wagon)
      super
    else
      puts 'В пассажирском поезде могут быть только пассажирские вагоны.'
    end
  end
end