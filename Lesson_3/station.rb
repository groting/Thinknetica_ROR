class Station
  attr_reader :trains, :name

  @@stations = []

  def self.all
    @@stations
  end 

  def initialize(name)
    @name = name
    @trains = []
    @@stations << self
  end

  def add_train(train)
    trains << train
  end

  def delete_train(train)
    trains.delete(train)
  end

  def types_of_trains(type)
    trains.select {|train| type == train.type}
  end

end
