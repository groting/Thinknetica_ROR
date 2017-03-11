class Station
  attr_reader :trains
  attr_reader :name

  def initialize(station_name)
    @name = station_name
    @trains = {}
  end

  def add_train(train)
    self.trains[train.number] = train.type
  end

  def delete_train(train)
    self.trains.delete(train.number)
  end

  def types_of_trains(type)
    self.trains.select  {|number, type_of_train| type == type_of_train}
  end

end
