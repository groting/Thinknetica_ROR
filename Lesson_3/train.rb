require_relative 'producer_name'
require_relative 'instance_counter'

class Train
  
  include ProducerName
  include InstanceCounter

  attr_reader  :type, :number, :wagons, :route
  attr_accessor :speed  

  NUMBER_FORMAT = /^(\d|\w){3}-?(\d|\w){2}$/

  @@trains = {}

  def self.find(number)
    @@trains[number]
  end

  def self.all
    @@trains
  end

  def initialize(number)
    @number = number
    validate!
    @wagons = []
    @speed = 0
    @type = 'Train'
    @current_station_index = 0
    @@trains[number] = self
    register_instance
  end

  def valid?
    validate!
  rescue
    false
  end

  def route=(route)
    @route = route
    route.stations.first.add_train(self)
  end

  def add_speed(speed)
    self.speed += speed
  end

  def stop
    self.speed = 0
  end

  def add_wagon(wagon)
    raise "Изменения длины состава может осуществляться только если поезд не движется." if speed != 0 
    wagons << wagon
  end

  def delete_wagon
    raise "Изменения длины состава может осуществляться только если поезд не движется." if speed != 0
    raise "В составе нет вагонов." if wagons.empty?
    wagons.delete(wagons.last)
  end

  def move_forward
    raise "Поезд не может переместиться туда." if current_station_index + 1 > route.stations.size-1 
    route.stations[current_station_index].delete_train(self)
    self.current_station_index +=  1
    route.stations[current_station_index].add_train(self)  
  end

   def move_backward
    raise "Поезд не может переместиться туда." if current_station_index - 1 < 0
    route.stations[current_station_index].delete_train(self)
    self.current_station_index -= 1
    route.stations[current_station_index].add_train(self)  
  end

  def next_station
    if  current_station_index == route.stations.size-1 
      route.stations[-1].name
    else
      route.stations[current_station_index +1]
    end
  end 

    def current_station
      route.stations[current_station_index]
    end

    def previous_station
      if current_station_index == 0
        route.stations[0]
      else
        route.stations[current_station_index-1]
      end
    end

    protected

    attr_accessor :current_station_index 
    # Перемещенно в Protected так как используется для внутренних вычислений и не должно задаваться снаружи

    def validate!
      raise "Неверный формат номера!" if number !~ NUMBER_FORMAT
      true
    end
end
