require "./library.rb"

describe Library do
  BOOKS = ["War and Peace", "The Brothers Karamazov", "The Captain's Daughter", "Crime and Punishment"]
  READERS = ["John", "Joe", "Jack"]

  before(:each) do
    @lib = Library.new
  end

  it "returns 'No orders' for getting min delay on no orders library" do
    @lib.min_delay.should eq("No orders")
  end

  it "returns 00:01:40 for getting min delay on one order library" do
    order = Time.new
    issue = order + 100
    @lib.add(BookOrder.new(BOOKS.first, READERS.first, issue, order))
    @lib.min_delay.should eq("00:01:40")
  end

  it "returns 00:01:00 for getting min delay on few order library" do
    order = Time.new
    issue = order + 100
    @lib.add(BookOrder.new(BOOKS.first, READERS.first, issue, order))

    order = Time.new
    issue = order + 60
    @lib.add(BookOrder.new(BOOKS.last, READERS.last, issue, order))

    @lib.min_delay.should eq("00:01:00")
  end

  it "returns 2 for getting not satisfied orders" do
    5.times { @lib.add(BookOrder.new(BOOKS.first, READERS.last, Time.now)) }
    2.times { @lib.add(BookOrder.new(BOOKS.first, READERS.last)) }
  end

  it "returns #{READERS.first} for getting who often takes the #{BOOKS.first} book" do
    3.times { @lib.add(BookOrder.new(BOOKS.first, READERS.first)) }
    2.times { @lib.add(BookOrder.new(BOOKS.first, READERS.last)) }

    @lib.best_reader(BOOKS.first).should eq(READERS.first)
  end   

  it "returns #{READERS.last} for getting who often takes the #{BOOKS.last} book" do
    3.times { @lib.add(BookOrder.new(BOOKS.last, READERS.first)) }
    5.times { @lib.add(BookOrder.new(BOOKS.last, READERS.last)) }

    @lib.best_reader(BOOKS.last).should eq(READERS.last)
  end

  it "returns #{BOOKS.last} for getting most popular book" do
    3.times { @lib.add(BookOrder.new(BOOKS.first, READERS.first)) }
    5.times { @lib.add(BookOrder.new(BOOKS.last, READERS.last)) }

    @lib.popular_book.should eq(BOOKS.last)
  end

  it "returns 2 for getting how many people ordered one of the three most popular books." do
    5.times { @lib.add(BookOrder.new(BOOKS.last, READERS.last)) }
    4.times { @lib.add(BookOrder.new(BOOKS[2], READERS.first)) }
    4.times { @lib.add(BookOrder.new(BOOKS.first, READERS.first)) }

    1.times { @lib.add(BookOrder.new(BOOKS[1], READERS[1])) }
    2.times { @lib.add(BookOrder.new(BOOKS[1], READERS.first)) }
    @lib.peoples_count_ordered_one_popular_book(3).should eq(2)
  end
end
