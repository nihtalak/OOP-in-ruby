# TASK 2

class MailOrder
  attr_reader :city, :street, :house, :apartment, :destination, :value

  def initialize(hash = {})
    puts self.instance_variables
    @city = hash[:city] || "no city"
    @value = hash[:value] || 0
    @street = hash[:street] || "no street"
    @house = hash[:house] || "no house"
    @apartment = hash[:apartment] || "no apartment"
    @destination = hash[:destination] || "no destination"
  end

  def address
    "#{@city}, #{@street}, #{@house}, #{@apartment}"
  end
end

class PostOffice
  def initialize
    @orders = []
  end

  # the number of parcels sent to some city 
  def send_to_city(city)
    @orders.select { |order| order.city == city }.size
  end

  # how many parcels with value higher than 10 were sent 
  def value_fiter(value)
    @orders.select { |order| order.value > value }.size
  end

  # what is the most popular address
  def popular_address
    addresses = Hash.new(0)
    @orders.each { |order| addresses[order.address] += 1 }  
    addresses.max_by{ |key, value| value }.first
  end

  def add(mail_order)
    @orders << mail_order
  end
end