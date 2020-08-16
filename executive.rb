require './room'
module HotelManagement
  
  class Executive < Room
    def initialize(params)
      @type = 'Executive'
      super(params)
    end

  end
end