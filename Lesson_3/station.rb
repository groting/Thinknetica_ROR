require_relative 'validation'

class Station
  attr_reader :trains, :name

  @@stations = {}

  include Validation

  def self.all
    @@stations
  end

  def self.find(name)
    @@stations[name]
  end

  validate('name', 'presence')

  def initialize(name)
    @name = name
    validate!
    @trains = []
    @@stations[name] = self
  end

  def each_train
    trains.each { |train| yield(train) }
  end

  def add_train(train)
    trains << train
  end

  def delete_train(train)
    trains.delete(train)
  end

  def types_of_trains(type)
    trains.select { |train| type == train.type }
  end
end
