class Route
  attr_reader :stations, :name

  @@routes = {}

  def self.find(name)
    @@routes[name]
  end

  def self.all
    @@routes
  end

  def initialize(first_station, last_station, name)
    @stations = [first_station, last_station]
    @name = name
    validate!
    @@routes[name] = self
  end

  def valid?
    validate!
  rescue
    false
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

  protected

  def validate!
    raise 'Название маршрута не может быть меньше 3 символов!' if name.nil? || name.size < 3
    raise 'Начальная и конечная станции должны быть объектами класса Station!' if !stations.first.is_a?(Station) || !stations.last.is_a?(Station)
    true
  end
end
