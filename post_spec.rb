require "./post.rb"

describe PostOffice do
  CITIES = ["New York", "Kiev", "Moscow"]

  before(:each) do 
    @post = PostOffice.new
  end

  it "returns 10 for getting how many parcels were sent to #{CITIES.first}" do
    3.times { @post.add(MailOrder.new(city: CITIES.first)) }
    2.times { @post.add(MailOrder.new(city: CITIES.last)) }
    7.times { @post.add(MailOrder.new(city: CITIES.first)) }

    @post.send_to_city(CITIES.first).should eq(10)
  end

  it "returns 10 for getting how many parcels were sent to #{CITIES.last}" do
    3.times { @post.add(MailOrder.new(city: CITIES.first)) }
    2.times { @post.add(MailOrder.new(city: CITIES.last)) }
    7.times { @post.add(MailOrder.new(city: CITIES.first)) }

    @post.send_to_city(CITIES.last).should eq(2)
  end

  it "returns 15 for getting how many parcels with value higher than 10 were sent" do
    3.times { @post.add(MailOrder.new(value: 100)) }
    2.times { @post.add(MailOrder.new(value: 3)) }
    7.times { @post.add(MailOrder.new(value: 40)) }
    5.times { @post.add(MailOrder.new(value: 15)) }

    @post.value_fiter(10).should eq(15)
  end

  it "returns 'New York, Fulton Street, 10, 25' for getting most popular address" do
    10.times { @post.add(MailOrder.new(city: "New York", street: "Fulton Street", house: "10", apartment: 25)) }
    8.times { @post.add(MailOrder.new(city: "Kiev", street: "Fulton Street", house: "10", apartment: 25)) }
    4.times { @post.add(MailOrder.new(city: "Moscow", street: "Fulton Street", house: "150", apartment: 25)) }

    @post.popular_address.should eq("New York, Fulton Street, 10, 25")
  end
end