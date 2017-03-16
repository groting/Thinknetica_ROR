require_relative 'wagon'

class PassengerWagon < Wagon

  def occupy
    raise "Свободного места не осталось!" if free_space == 0
    self.free_space -=1
  end
end
