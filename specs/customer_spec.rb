require 'rspec'
require './hotel'
require 'pry'

describe "Customer" do

  it "should find a customer" do
    cust1 = Customer.create(name: 'Rohit', phone: '99999999', address: "address line 1")
    cust2 = Customer.create(name: 'Rohit', phone: '99999999', address: "address line 2")
    expect(Customer.find(1) ).to eq(cust1)
  end

  let(:create_customer){Customer.create(name: 'Rohit', phone: '99999999', address: "address line 1")}
  it "should add new customer" do
    expect { create_customer }.to change { Customer.customers.count }.by(1)
  end
end