require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'cargo_wagon'
require_relative 'passenger_wagon'
require_relative 'station'
require_relative 'route'

class Main

  def run
    loop do

      system('clear')

      puts 'Добро пожаловать в Поезда v 1.2'
      puts 'Список доступных команд:'
      puts '1) Создать станцию(а), Создать поезд(б), Создать маршрут(в).'
      puts '2) Изменить маршрут(г), Назначить маршрут поезду(д).' 
      puts '3) Добавить вагон(е), Отцепить вагон(ж).'
      puts '4) Переместить поезд (вперед(з)\назад(и)) по маршруту.'
      puts '5) Просмотреть список станций(к), Просмотреть список поездов на станции(л).'
      puts '6) Просмотреть список вагонов поезда(м), Занять место в вагоне(н).'
      puts '7) Выход.'

      user_answer = gets.chomp
      system('clear')

      case user_answer 
    
      when 'а'
        create_station
      when 'б'
        create_train
      when 'в'
        create_route
      when 'г'
        change_route
      when 'д'
        set_train_route
      when 'е'
        attach_wagon
      when 'ж'
        detach_wagon
      when 'з'
        train_go_forward
      when 'и'
        train_go_backward
      when 'к'
        list_of_stations  
      when 'л'  
        trains_at_station
      when 'м'
        wagons_in_train
      when 'н'
        occupy_wagon
      when 'Выход'
        break
      else
        puts 'Такой команды нет.'
      end
      STDIN.getc
    end
  rescue Exception => e
    puts "Произошла ошибка: #{e.message}. Повторите попытку."
    STDIN.getc
    retry 
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
    puts 'Введите номер поезда:'
    train_number = gets.chomp
    raise 'Такой поезд уже существует!' if Train.all.key?(train_number)
    puts 'Введите тип поезда(Грузовой(а)\Пассажирский(б)):'
    train_type = gets.chomp
    if train_type  == 'а'
      CargoTrain.new(train_number)
      puts 'Поезд создан!'
    elsif train_type == 'б'
      PassengerTrain.new(train_number)
      puts 'Поезд создан!'
    else
      raise 'Тип поезда указан неверно!'
    end 
  end

  def create_route
    puts 'Введите название маршрута:'
    route_name = gets.chomp
    raise 'Такой маршрут уже существует!' if Route.all.key?(route_name)
    puts 'Введите начальную станцию маршрута:'
    station = gets.chomp
    raise 'Такой станции не существует!' unless Station.all.key?(station)
    route_first_station = Station.all[station]
    puts 'Введите конечную станцию маршрута:'
    station = gets.chomp
    raise 'Такой станции не существует!' unless Station.all.key?(station)
    route_last_station = Station.all[station]
    Route.new(route_first_station, route_last_station, route_name)
    puts 'Маршрут создан!'  
  end

  def change_route
    puts 'Введите название маршрута:'
    route_name = gets.chomp
    raise 'Такого маршрута не существует!' unless Route.all.key?(route_name)
    puts 'Введите действие (Добавить(а)\Удалить(б)):'
    action = gets.chomp
    if  action == 'а'
      puts 'Введите название станции:'  
      station = gets.chomp
      raise 'Такой станции не существует!' unless Station.all.key?(station)
      Route.all[route_name].add(Station.all[station])
      puts 'Станция добавлена к маршруту!'
    elsif action == 'б'
      puts 'Введите название станции:'
      station = gets.chomp
      raise 'Такой  станции не существует!' unless Station.all.key?(station)
      Route.all[route_name].delete(Station.all[station])
    else
      raise 'Такого действия не существует!'
    end    
  end

  def set_train_route
    puts 'Введите номер поезда:'
    train_number = gets.chomp
    raise 'Такого поезда не существует!' unless Train.all.key?(train_number)      
    puts 'Введите название маршрута:'
    route_name = gets.chomp
    raise 'Такого маршрута не существует!' unless Route.all.key?(route_name)
    Train.all[train_number].route = Route.all[route_name]
    puts 'Маршрут назначен!'
  end

  def attach_wagon
    puts 'Введите номер поезда:'
    train_number = gets.chomp
    raise 'Такого поезда не существует!' unless Train.all.key?(train_number)
    if Train.all[train_number].type == 'Грузовой'
      puts 'Введите вместимость вагона:'
      capacity = gets.chomp.to_f
      Train.all[train_number].add_wagon(CargoWagon.new(capacity))
      puts 'Вагон добавлен!'
    else
      puts 'Введите количество мест в вагоне:'
      capacity = gets.chomp.to_i
      Train.all[train_number].add_wagon(PassengerWagon.new(capacity))
      puts 'Вагон добавлен!'
    end
  end

  def detach_wagon
    puts 'Введите номер поезда:'
    train_number = gets.chomp
    raise 'Такого поезда не существует!' unless Train.all.key?(train_number)
    Train.all[train_number].delete_wagon
    puts 'Вагон удален!'
  end

  def train_go_forward
    puts 'Введите номер поезда:'
    train_number = gets.chomp
    raise 'Такого поезда не существует!' unless Train.all.key?(train_number) 
    Train.all[train_number].move_forward
    puts 'Поезд перемещен вперед!'
  end

  def train_go_backward
    puts 'Введите номер поезда:'
    train_number = gets.chomp
    raise 'Такого поезда не существует!' unless Train.all.key?(train_number) 
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
    raise 'Такой станции не существует!' unless Station.all.key?(station)
    Station.all[station].each_train {|train| puts "Номер поезда:#{train.number} Тип: #{train.type} Количество вагонов:#{train.wagons.size}"}
  end

  def wagons_in_train
    puts 'Введите номер поезда:'
    train_number = gets.chomp
    raise 'Такого поезда не существует!' unless Train.all.key?(train_number) 
    Train.all[train_number].each_wagon do |wagon| 
      puts "Номер вагона: #{wagon.number} #{wagon.info}"
    end
  end

  def occupy_wagon
    puts 'Введите номер поезда:'
    train_number = gets.chomp
    raise 'Такого поезда не существует!' unless Train.all.key?(train_number)
    puts 'Введите номер вагона:'
    wagon_number = gets.chomp.to_i
    raise 'Такого вагона не существует!' unless Train.all[train_number].wagons.key?(wagon_number)
    if Train.all[train_number].wagons[wagon_number].is_a? CargoWagon
      puts 'Какой объем вы хотите занять?'
      volume = gets.chomp.to_f
      Train.all[train_number].wagons[wagon_number].occupy(volume)
      puts 'Место занято!'
    else
      Train.all[train_number].wagons[wagon_number].occupy
      puts 'Место занято!'
    end
  end
end

app = Main.new
app.run