require_relative 'wagon'

class Cargo_wagon < Wagon

  def initialize(number)
    super
    @type = 'Cargo wagon'
  end
end