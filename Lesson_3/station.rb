class Station
  attr_reader :trains, :name

  @@stations = {}

  def self.all
    @@stations
  end

  def self.find(name)
    @@stations[name]
  end 

  def initialize(name)
    @name = name
    validate!
    @trains = []
    @@stations[name] = self
  end

  def valid?
    validate!
  rescue
    false
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

  protected

  def validate!
    raise "Название станции не может быть меньше 3 символов!" if name.size < 3 || name.nil?
    true
  end
end
