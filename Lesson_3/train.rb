class Train
  attr_accessor :speed
  attr_accessor :num_of_wagons
  attr_accessor :train_route
  attr_accessor :type
  attr_accessor :current_station
  attr_accessor :number

  def initialize(number, type, num_of_wagons)
    @number = number
    @type = type
    @num_of_wagons = num_of_wagons
    @train_route = []
    @current_station = 0
    @speed = 0
  end

  def add_speed(speed)
    self.speed += speed
  end

  def stop
    self.speed = 0
  end

  def train_length_change(value = "add")
    if self.speed == 0 
      if value.downcase == "add"
        self.num_of_wagons += 1
      elsif value.downcase == "delete"
        self.num_of_wagons -= 1
      else
      puts "Используйте 'add' для прицепки вагона в состав и 'delete' для отцепки."
      end
    else 
      puts "Изменения длины состава может осуществляться только если поезд не движется."
    end
  end

  def train_move(num)
    self.current_station += num
    if self.current_station > self.train_route.route.size-1 || self.current_station < 0
      puts "Поезд не может переместиться туда."
      self.current_station -=num
    end
  end

  def train_station
    if self.current_station == 0
      puts "Поезд на начальной станции: #{self.train_route.route[0]}. Cледующая станция: #{self.train_route.route[1]}."
    elsif  self.current_station == self.train_route.route.size-1 
      puts "Предыдущая станция: #{self.train_route.route[-2]}. Поезд достиг конечной станции: #{self.train_route.route[-1]}."
    else
       puts "Предыдущая станция: #{self.train_route.route[self.current_station-1]}. Текущая станция: #{self.train_route.route[self.current_station]} Cледующая станция: #{self.train_route.route[self.current_station+1]}."
    end
  end 
end
