require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'cargo_wagon'
require_relative 'passenger_wagon'
require_relative 'station'
require_relative 'route'

class Main

  def run
    loop do

      puts 'Добро пожаловать в Поезда v 1.1'
      puts 'Список доступных команд:'
      puts '1) Создать станцию, Создать поезд, Создать маршрут.'
      puts '2) Изменить маршрут, Назначить маршрут поезду.' 
      puts '3) Добавить вагон, Отцепить вагон.'
      puts '4) Переместить поезд (вперед\назад) по маршруту.'
      puts '5) Просмотреть список станций, Просмотреть список поездов на станции.'
      puts '6) Выход.'

      case gets.chomp
    
      when 'Создать станцию'
        create_station
      when 'Создать поезд'
        create_train
      when 'Создать маршрут'
        create_route
      when 'Изменить маршрут'
        change_route
      when 'Назначить маршрут поезду'
        set_train_route
      when 'Добавить вагон'
        attach_wagon
      when 'Удалить вагон'
        detach_wagon
      when 'Переместить поезд вперед по маршруту'
        train_go_forward
      when 'Переместить поезд назад по маршруту'
        train_go_backward
      when 'Просмотреть список станций'
        list_of_stations  
      when 'Просмотреть список поездов на станции'  
        trains_at_station
      when 'Выход'
        break
      else
        puts 'Такой команды нет.'
      end
    end
  end

private

  def create_station
    puts 'Введите название станции:'
    station = gets.chomp
    raise 'Такая станция уже существует!' if Station.all.key?(station)
    Station.new(station)
    puts 'Cтанция создана!' 
  end
  
  def create_train
    attempt = 0
    puts 'Введите номер поезда:'
    train_number = gets.chomp
    raise 'Такой поезд уже существует!' if Train.all.key?(train_number)
    puts 'Введите тип поезда(Грузовой\Пассажирский):'
    train_type = gets.chomp
    if train_type  == 'Грузовой'
      CargoTrain.new(train_number)
      puts 'Поезд создан!'
    elsif train_type == 'Пассажирский'
      PassengerTrain.new(train_number)
      puts 'Поезд создан!'
    else
      raise 'Тип поезда указан неверно!'
    end 
  rescue Exception => e
    puts "Произошла ошибка: #{e.message}. Повторите попытку."
    attempt += 1
    retry if attempt < 3
    raise "Превышено количество попыток!" 
  end

  def create_route
    puts 'Введите название маршрута:'
    route_name = gets.chomp
    raise 'Такой маршрут уже существует!' if Route.all.key?(route_name)
    puts 'Введите начальную станцию маршрута:'
    station = gets.chomp
    raise 'Такой станции не существует!' if !Station.all.key?(station)
    route_first_station = Station.all[station]
    puts 'Введите конечную станцию маршрута:'
    station = gets.chomp
    raise 'Такой станции не существует!' if !Station.all.key?(station)
    route_last_station = Station.all[station]
    Route.new(route_first_station, route_last_station)
    puts 'Маршрут создан!'  
  end

  def change_route
    puts 'Введите название маршрута:'
    route_name = gets.chomp
    raise 'Такого маршрута не существует!' if !Route.all.key?(route_name)
    puts 'Введите действие (Добавить\Удалить):'
    action = gets.chomp
    if  action == 'Добавить'
      puts 'Введите название станции:'  
      station = gets.chomp
      raise 'Такой станции не существует!' if !Station.all.key?(station)
      Route.all[route_name].add(Station.all[station])
      puts 'Станция добавлена к маршруту!'
    elsif action == 'Удалить'
      puts 'Введите название станции:'
      station = gets.chomp
      raise 'Такой  станции не существует!' if !Station.all.key?(station)
      Route.all[route_name].delete(Station.all[station])
    else
      raise 'Такого действия не существует!'
    end    
  end

  def set_train_route
    puts 'Введите номер поезда:'
    train_number = gets.chomp.to_i
    raise 'Такого поезда не существует!' if !Train.all.key?(train_number)      
    puts 'Введите название маршрута:'
    route_name = gets.chomp
    raise 'Такого маршрута не существует!' if !Route.all.key?(route_name)
    Train.all[train_number].route = Route.all[route_name]
    puts 'Маршрут назначен!'
  end

  def attach_wagon
    puts 'Введите номер поезда:'
    train_number = gets.chomp.to_i
    raise 'Такого поезда не существует!' if !Train.all.key?(train_number)
    if Train.all[train_number].type == 'Cargo train'
      Train.all[train_number].add_wagon(CargoWagon.new)
      puts 'Вагон добавлен!'
    else
      Train.all[train_number].add_wagon(PassengerWagon.new)
      puts 'Вагон добавлен!'
    end
  end

  def detach_wagon
    puts 'Введите номер поезда:'
    train_number = gets.chomp.to_i
    raise 'Такого поезда не существует!' if !Train.all.key?(train_number)
    Train.all[train_number].delete_wagon
    puts 'Вагон удален!'
  end

  def train_go_forward
    puts 'Введите номер поезда:'
    train_number = gets.chomp.to_i
    raise 'Такого поезда не существует!' if !Train.all.key?(train_number) 
    Train.all[train_number].move_forward
    puts 'Поезд перемещен вперед!'
  end

  def train_go_backward
    puts 'Введите номер поезда:'
    train_number = gets.chomp.to_i
    raise 'Такого поезда не существует!' if !Train.all.key?(train_number) 
    Train.all[train_number].move_backward
    puts 'Поезд перемещен назад!'
  end

  def list_of_stations
    raise 'Вы пока не создали ни одной станции!' if Station.all.empty?
    puts Station.all.keys
  end

  def trains_at_station
    puts 'Введите название стании:'
    station = gets.chomp
    raise 'Такой станции не существует!' if !Station.all.key?(station)
    Station.all[station].trains.each {|train| puts train.number}
  end
end

app = Main.new
app.run