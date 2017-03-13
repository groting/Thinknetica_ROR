require_relative 'wagon'

class Passenger_wagon < Wagon

  def initialize(number)
    super
    @type = 'Passenger wagon'
  end
end
