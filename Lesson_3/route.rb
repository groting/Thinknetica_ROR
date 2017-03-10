class Route
  attr_accessor :route
  attr_accessor :last_station
  attr_accessor :first_station

  def initialize(first_station, last_station)
    @first_station = first_station.station_name
    @last_station = last_station.station_name
    @route = []
    @route << first_station.station_name << last_station.station_name
  end

  def change_route(value, station_name)
    if value.downcase == "add"
      if self.route.include?(station_name) 
        puts "Такая станция уже есть в маршруте." 
      else
        self.route.delete_at(-1)
        self.route << station_name << self.last_station
      end
    elsif value.downcase == "delete"
      if self.route.include?(station_name)
        if station_name == self.first_station || station_name == self.last_station
          puts "Нельзя удалять начальную или конечную станцию!"
        else
          self.route.delete(station_name)
        end
      else
        puts "Такой станции нет в маршруте."
      end
    else
    puts "Используйте 'add' для добавления станции в маршрут и 'delete' для удаления."
    end
  end

end