require 'rspec'
require './hotel'
require './room'

describe "Room" do
  before(:each) { HotelManagement::Room.instance_variable_set :@all, [] }
  
  it "should add a Executive room" do
    expect{HotelManagement::Room.create{HotelManagement::Executive.new(price: 1000, number: 'F11')}}.to change{HotelManagement::Room.all.count}.by(1)
  end

  it "should add a Standard room" do
    expect{HotelManagement::Room.create{HotelManagement::Standard.new(price: 800, number: 'S11')}}.to change{HotelManagement::Room.all.count}.by(1)
  end

  it "Customer should find a standard room" do
    HotelManagement::Room.create{HotelManagement::Standard.new(price: 800, number: 'S11')}
    expect(HotelManagement::Room.find('S11').type).to eq('Standard')
  end

  it "Customer should find a executive room" do
    HotelManagement::Room.create{HotelManagement::Executive.new(price: 1000, number: 'F11')}
    expect(HotelManagement::Room.find('F11').type).to eq('Executive')
  end

  it "should raise exception room not found" do
    expect{HotelManagement::Room.find('111')}.to raise_error('RoomNotFoundException')
  end

  it "should allow customer to checkin" do
    HotelManagement::Room.create{HotelManagement::Standard.new(price: 800, number: 'S11')}

    room = HotelManagement::Room.find('S11')
    room.checkin(customer_id: 1)
    expect(room.available).to eq false
  end

  it "should give available room count" do
    HotelManagement::Room.create{HotelManagement::Standard.new(price: 800, number: 'S11')}
    HotelManagement::Room.create{HotelManagement::Executive.new(price: 1000, number: 'F11')}

    expect(HotelManagement::Room.active.count).to eq 2
  end

  it "should checkout customer" do
    HotelManagement::Room.create{HotelManagement::Standard.new(price: 800, number: 'S11')}
    room = HotelManagement::Room.find('S11')
    room.checkin(customer_id: 1)
    room.checkout

    expect(room.available).to eq true
  end

  it "shold not allow checkin to an allocated room" do
    HotelManagement::Room.create{HotelManagement::Standard.new(price: 800, number: 'S11')}

    room = HotelManagement::Room.find('S11')
    room.checkin(customer_id: 1)
    expect{room.checkin(customer_id: 1)}.to raise_error('HotelManagement::Room::RoomAllocatedException')
  end

  it "shold not allow checkout from an available room" do
    HotelManagement::Room.create{HotelManagement::Standard.new(price: 800, number: 'S11')}

    room = HotelManagement::Room.find('S11')

    expect{room.checkout}.to raise_error('HotelManagement::Room::RoomNotAllocatedException')
  end
end