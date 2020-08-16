require './room'
module HotelManagement

  class Standard < Room
    def initialize(params)
      @type = 'Standard'
      super(params)
    end

  end
end
