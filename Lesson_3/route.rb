require_relative 'validation'

class Route
  attr_reader :stations, :name

  include Validation

  @@routes = {}

  validate('name', 'presence')
  #validate('first_station', 'presence')
  #validate('last_station', 'presence')

  def self.find(name)
    @@routes[name]
  end

  def self.all
    @@routes
  end

  def initialize(first_station, last_station, name)
    @stations = [first_station, last_station]
    @name = name
    puts first_station.class
    puts first_station.inspect
    validate!
    @@routes[name] = self
  end

  def add(station)
    raise 'Такая станция уже есть в маршруте.' if stations.include?(station)
    stations.insert(-2, station)
    puts 'Станция добавлена к маршруту!'
  end

  def delete(station)
    raise 'Такой станции нет в маршруте.' unless stations.include?(station)
    raise 'Нельзя удалять начальную или конечную станцию!' if station == stations.first || station == stations.last
    stations.delete(station)
    puts 'Станция удалена из маршрута!'
  end
end
