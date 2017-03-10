class Station
  attr_accessor :trains
  attr_accessor :station_name

  def initialize(station_name)
  @station_name = station_name
  @trains = {}
  end

  def add_train(train)
    self.trains[train.number] = train.type
  end

  def delete_train(train)
    self.trains.delete(train.number)
  end

  def trains_in_station
    puts self.trains
  end

  def types_of_trains(type)
    self.trains.each  {|number, type_of_train| puts number if type == type_of_train}
  end
end
