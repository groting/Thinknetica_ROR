require_relative 'train'

class PassengerTrain < Train

  def initialize(number)
    super
    @type = 'Passenger train'
  end

  def passenger_wagon?(wagon)
    wagon == PassengerWagon
  end

  def add_wagon(wagon)
    if Passenger_wagon?(wagon)
      super
    else
      puts 'В пассажирском поезде могут быть только пассажирские вагоны.'
    end
  end
end