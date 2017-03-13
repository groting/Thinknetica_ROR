require_relative 'train'

class Cargo_train < Train

  def initialize(number)
    super
    @type = 'Cargo train'
  end

  def Cargo_wagon?(wagon)
    wagon.type == 'Cargo wagon'
  end

  def add_wagon(wagon)
    if Cargo_wagon?(wagon)
      super
    else
      puts 'В грузовом поезде могут быть только грузовые вагоны.'
    end
  end
end