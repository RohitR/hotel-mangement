module HotelManagement

  class Room

    attr_reader :number, :type, :price, :available, :allocations
    @all = []
    def initialize(args)
      @number = args[:number]
      @price = args[:price]
      @allocations = []
      @available = true
    end

    def checkin(customer_id: )
      raise RoomAllocatedException unless available

      @allocations << RoomAllocation.create(room_no: self.number, customer_id: customer_id)
      @available = false
    end

    def checkout
      raise RoomNotAllocatedException if available

      allocation = @allocations.detect{|s| s.checkout.nil?}
      allocation.update_checkout
      @available = true
    end

    def find_customer(customer_id)
      @allocations.detect{|allocation| allocation.customer_id == customer_id}
    end

    class << self
      attr_accessor :all

      def create
        @all << yield
      end

      def active
        @all.select{|room| room.available}
      end

      def find(room_no)
        room = @all.detect{|room| room.number == room_no}
        raise RoomNotFoundException unless room
        room
      end

    end

    class RoomNotAllocatedException < StandardError
      "Room not allocated yet!"
    end

    class RoomAllocatedException < StandardError
      "Room already allocated!"
    end
  end
end