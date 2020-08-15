class Customer
  attr_reader :name, :address, :phone
  @customers = []
  @last_id = 0

  class << self
    attr_reader :last_id, :customers
    #default value set for last_id

    def create(name:, phone:, address:)
      @customers << new(last_id+1, name, phone, address)
    end

  end


  def initialize(id, name, phone, address)
    @name = name
    @phone = phone
    @address = address
  end

  private_class_method :new
end