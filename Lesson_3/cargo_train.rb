require_relative 'train'

class CargoTrain < Train
  def initialize(number)
    super
    @type = 'Грузовой'
  end

  def add_wagon(wagon)
    raise 'В грузовом поезде могут быть только грузовые вагоны.' unless wagon.is_a? CargoWagon
    super
  end
end
