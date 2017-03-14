require_relative 'train'

class CargoTrain < Train

  def initialize(number)
    super
    @type = 'Cargo train'
  end

  def cargo_wagon?(wagon)
    wagon == CargoWagon
  end

  def add_wagon(wagon)
    if Cargo_wagon?(wagon)
      super
    else
      puts 'В грузовом поезде могут быть только грузовые вагоны.'
    end
  end
end