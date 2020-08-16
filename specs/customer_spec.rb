require 'rspec'
require './hotel'

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

  it "should update customer" do
    customer = Customer.find(1)
    customer.update({name: 'Jack'})
    expect(Customer.find(1).name).to eq 'Jack'
  end

  it "should fail on customer updation" do
    customer = Customer.find(1)
    expect{
      customer.update({mobile_no: '900009'})
    }.to raise_error("mobile_no is not a valid Customer attribute")
  end
end