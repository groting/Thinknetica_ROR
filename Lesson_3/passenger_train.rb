require_relative 'train'

class PassengerTrain < Train

  def initialize(number)
    super
    @type = 'Passenger train'
  end

  def add_wagon(wagon)
    if wagon.is_a? PassengerWagon
      super
    else
      puts 'В пассажирском поезде могут быть только пассажирские вагоны.'
    end
  end
end
