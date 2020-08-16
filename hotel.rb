require './executive'
require './standard'
require './room_allocation'
require './room'
require './customer'

module HotelManagement
 
  class Hotel

    def check_in
      puts "please enter room number"
      room = Room.find(gets.chomp)
      puts "Please enter customer id"
      customer = search_for_customer
      room.checkin(customer_id: customer.id)
    end

    def list_available_rooms
      puts "room_no           type          price"
      Room.active.each do |available_room|
        puts "#{available_room.number}        #{available_room.type}        #{available_room.price}"
      end
    end

    def add_customer
      puts "Enter Customer name"
      name = gets.chomp
      puts "Enter address"
      address = gets.chomp
      puts "Enter phone"
      phone = gets.chomp
      Customer.create(name: name, phone: phone, address: address)
    end

    def checkout
      puts "please enter room number"
      room = Room.find(gets.chomp)
      room.checkout
    end

    def find_customer
      puts "Enter customer id"
      id = gets.chomp
      customer = Customer.find(id)
      if customer.nil?
        puts "Customer not found"
        return
      end
      room = @rooms.find{|room| !(room.find_customer(customer.id).nil?)}
      if room
        puts "Customer #{customer.name} is allocated #{room.type} Room: #{room.number}"
      else
        puts "No rooms allocated yet"
      end
    end

    def update_customer
      puts "Enter customer id"
      customer = search_for_customer
      return "customer not found" unless customer
      puts "enter name"
      name = gets.chomp
      puts "enter phone"
      phone = gets.chomp
      puts "enter address"
      address = gets.chomp
      updated_customer = customer.update(name: name, phone: phone, address: address)
      puts "user details updated!!"
    end

    private

    def search_for_customer
      id = gets.chomp
      customer = Customer.find(id)
      return customer if customer
      puts "Customer not found"
      search_for_customer
    end
  end
end
class RoomNotFoundException < StandardError
    "Room not found, try again"
end
