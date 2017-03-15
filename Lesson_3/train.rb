require_relative 'producer_name'
require_relative 'instance_counter'

class Train
  
  include ProducerName
  include InstanceCounter

  attr_reader  :type, :number, :wagons, :route
  attr_accessor :speed  

  @@trains = []

  def self.find(number)
    @@trains.find {|train| train.number == number}
  end

  def initialize(number)
    @number = number
    @wagons = []
    @speed = 0
    @type = 'Train'
    @current_station_index = 0
    @@trains << self
    register_instance
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
    if speed == 0 
      wagons << wagon
    else 
      puts "Изменения длины состава может осуществляться только если поезд не движется."
    end
  end

  def delete_wagon
    if speed == 0
      if wagons.any?
        wagons.delete(wagons.last)
      else 
        puts "В составе нет вагонов."
      end    
    else 
      puts "Изменения длины состава может осуществляться только если поезд не движется."
    end
  end

  def move_forward
    if current_station_index + 1 > route.stations.size-1 
      puts "Поезд не может переместиться туда."
    else
      route.stations[current_station_index].delete_train(self)
      self.current_station_index +=  1
      route.stations[current_station_index].add_train(self) 
    end 
  end

   def move_backward
    if current_station_index - 1 < 0
      puts "Поезд не может переместиться туда."
    else
      route.stations[current_station_index].delete_train(self)
      self.current_station_index -= 1
      route.stations[current_station_index].add_train(self) 
    end 
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
end
