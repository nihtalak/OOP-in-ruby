# TASK 1

class BookOrder
  attr_reader :book_name, :name, :order_date, :issue_date

  def initialize(book_name, name, issue_date = nil, order_date = Time.now)
    @book_name, @name, @order_date, @issue_date = book_name, name, order_date, issue_date 
  end

  def delay
    @issue_date ? @issue_date - @order_date : nil 
  end
end

class Library
  def initialize
    @orders = []
  end

  # the smallest period for which library found a book
  def min_delay
    order = @orders.min_by { |x| x.delay }
    delay = order.nil? ? 0 : order.delay
    Time.at(delay).getgm.strftime("%H:%M:%S")
  end

  # how many orders were not satisfied 
  def not_satisfied
    @orders.inject(0) { |s, order| order.issue_date.nil? ? s + 1 : s }
  end

  # who often takes the book
  def best_reader(book)
    readers = Hash.new(0)
    @orders.each { |order| readers[order.name] += 1 if order.book_name == book }  
    readers.max_by{ |key, value| value }.first
  end

  # what is the most popular book
  def popular_book
    books = Hash.new(0)
    @orders.each { |order| books[order.book_name] += 1 }  
    book = books.max_by{ |key, value| value }.first
  end

  # how many people ordered one of the __number__ most popular books.
  def peoples_count_ordered_one_popular_book(num)
    books = Hash.new(0)
    @orders.each { |order| books[order.book_name] += 1 }
    books = books.sort_by(&:last).take(num).map(&:first)
    readers = []
    @orders.each { |order| readers << order.name if books.include? order.book_name }
    readers.uniq.size
  end

  def add(book_record)
    @orders << book_record
  end
end