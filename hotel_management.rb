#!/usr/bin/env ruby
require './executive'
require './standard'
require './hotel'
module HotelManagement
  puts "1. Listing available room"
  puts "2. Check_in into room"
  puts "3. Check_out from room"
  puts "4. Add a Customer"
  puts "5. Find a Customer"
  puts "6. Update customer details"

  hotel = HotelManagement::Hotel.new
  Room.create do
    HotelManagement::Executive.new(price: 1000, number: 'F11')
  end
  Room.create do
    HotelManagement::Standard.new(price: 800, number: 'S11')
  end
  loop do
    input = gets.chomp

    case input.to_i
    when 1
      hotel.list_available_rooms
    when 2
      hotel.check_in
    when 3
      hotel.checkout
    when 4
      hotel.add_customer
    when 5
      hotel.find_customer
    when 6
      hotel.update_customer
    else
      puts "enter a valid input"
    end
      break if input == 'exit'
  end
end