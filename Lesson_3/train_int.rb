require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'cargo_wagon'
require_relative 'passenger_wagon'

module TrainInterface
  def create_train
    set_train_number
    raise 'Такой поезд уже существует!' if Train.all.key?(train_number)
    puts 'Введите тип поезда(Грузовой(а)\Пассажирский(б)):'
    train_type = gets.chomp
    raise 'Тип поезда указан неверно!' unless %w(а б).include?(train_type)
    if train_type == 'а'
      CargoTrain.new(train_number)
    else
      PassengerTrain.new(train_number)
    end
  end

  def set_train_route
    train_exist!
    route_exist!
    Train.all[train_number].route = Route.all[route_name]
    puts 'Маршрут назначен!'
  end

  def attach_wagon
    train_exist!
    if Train.all[train_number].type == 'Грузовой'
      puts 'Введите вместимость вагона:'
      capacity = gets.chomp.to_f
      Train.all[train_number].add_wagon(CargoWagon.new(capacity))
    else
      puts 'Введите количество мест в вагоне:'
      capacity = gets.chomp.to_i
      Train.all[train_number].add_wagon(PassengerWagon.new(capacity))
    end
  end

  def detach_wagon
    train_exist!
    Train.all[train_number].delete_wagon
    puts 'Вагон удален!'
  end

  def train_go_forward
    train_exist!
    Train.all[train_number].move_forward
    puts 'Поезд перемещен вперед!'
  end

  def train_go_backward
    train_exist!
    Train.all[train_number].move_backward
    puts 'Поезд перемещен назад!'
  end

  def wagons_in_train
    train_exist!
    raise 'В поезде пока нет вагонов!' if Train.all[train_number].wagons.empty?
    Train.all[train_number].each_wagon do |wagon|
      puts "Номер вагона: #{wagon.number} #{wagon.info}"
    end
  end

  def occupy_wagon
    train_exist!
    wagon_exist!
    if Train.all[train_number].wagons[wagon_number].is_a? CargoWagon
      puts 'Какой объем вы хотите занять?'
      volume = gets.chomp.to_f
      Train.all[train_number].wagons[wagon_number].occupy(volume)
    else
      Train.all[train_number].wagons[wagon_number].occupy
    end
    puts 'Место занято!'
  end

  def set_train_number
    puts 'Введите номер поезда:'
    @train_number = gets.chomp
  end

  def set_wagon_number
    puts 'Введите номер вагона:'
    @wagon_number = gets.chomp.to_i
  end

  def train_exist!
    set_train_number
    raise 'Такого поезда не существует!' unless Train.all.key?(train_number)
  end

  def wagon_exist!
    set_wagon_number
    raise 'Такого вагона не существует!' unless Train.all[train_number].wagons.key?(wagon_number)
  end

  attr_accessor :train_number, :wagon_number
end
