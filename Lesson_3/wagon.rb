class Wagon

  attr_reader :type, :number

  def initialize(number)
    @number = number
    @type = 'Wagon'
  end
end