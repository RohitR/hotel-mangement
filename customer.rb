class Customer
  attr_reader :name, :address, :phone, :id
  @customers = []
  @last_id = 0

  class << self
    attr_reader :last_id, :customers
    
    def create(name:, phone:, address:)
      @last_id += 1
      customer = new(@last_id, name, phone, address)
      @customers << customer
      customer
    end

    def find(id)
      @customers.detect{|cust| cust.id == id.to_i}
    end

  end

  class UnknownAttribute < StandardError
    def initialize(attr)
      @attr = attr
    end

    def message
      "#{@attr} is not a valid Customer attribute"
    end
  end

  def update(**args)
    args.each do |key, value|
      raise UnknownAttribute.new(key) unless updation_permitted_attributes.include?(key.to_s)
      instance_variable_set("@#{key}", value)
    end
  end

  def initialize(id, name, phone, address)
    @id = id
    @name = name
    @phone = phone
    @address = address
  end

  private_class_method :new
  
  private

  def updation_permitted_attributes
    %w{name address phone}
  end

end