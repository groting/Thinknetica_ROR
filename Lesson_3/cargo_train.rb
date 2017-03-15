require_relative 'train'

class CargoTrain < Train

  def initialize(number)
    super
    @type = 'Cargo train'
  end

  def add_wagon(wagon)
    if wagon.is_a? CargoWagon
      super
    else
      puts 'В грузовом поезде могут быть только грузовые вагоны.'
    end
  end
end
