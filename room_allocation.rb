class RoomAllocation
  attr_reader :room_no, :customer_id, :check_in, :checkout

  def initialize(**args)
    @room_no = args[:room_no]
    @customer_id = args[:customer_id]
    @check_in = args[:check_in]
  end

  def self.create(room_no:, customer_id:)
    new(
      room_no: room_no,
      customer_id: customer_id,
      check_in: Time.now
    )
  end

  def update_checkout
    @checkout = Time.now
  end
 
  private_class_method :new
end