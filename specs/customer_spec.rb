require 'rspec'
require './hotel'

describe "Add new Customer" do
  let(:create_customer){Customer.create(name: 'Rohit', phone: '99999999', address: "address line 1")}
  it "should add new customer" do
    expect { create_customer }.to change { Customer.customers.count }.by(1)
  end
end