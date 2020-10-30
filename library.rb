
# ****************************************
# Library system for checked-out items
# ****************************************


# Media super class

class Media
	attr_reader	:patron, :m_name, :due_y, :due_m, :due_d,:catalogue_id
	attr_writer :due_y, :due_m, :due_d
	def initialize(patron, release_year, m_name, due_d, due_m, due_y, catalogue_id) 
	    @patron = patron
	    @release_year = release_year
	    @m_name = m_name
	    @due_d = due_d
	    @due_m = due_m
	    @due_y = due_y
	    @catalogue_id = catalogue_id
	end

  def isOverDue() 
    return (due_y < $year) || ((due_y == $year) && (due_m < $month)) || ((due_y == $year) && (due_m == $month) && (due_d < $day))
  end
end

# Book class that inherits from the media superclass

class Book < Media
	def initialize(patron, release_year, m_name, due_d, due_m, due_y, catalogue_id, author, iSBN) 
		super(patron, release_year, m_name, due_d, due_m, due_y, catalogue_id)
		@author = author
		@iSBN = iSBN
	end
end

# DVD class that inherits from the media superclass

class DVD < Media
	def initialize(patron, release_year, m_name, due_d, due_m, due_y, catalogue_id, runtime, studio, director, actors) 
		super(patron, release_year, m_name, due_d, due_m, due_y, catalogue_id)
		@studio = studio
		@director = director
		@actors = actors
	end
end

# While global variables are a no-no, having today's date as one seems appropriate since all the objects use it
$year = 2020
$month = 4
$day = 28


b = Book.new("Sergei Bond", 2008, "The Ruby Programming Language", 16, 4, 2020, 105777, "David Flanagan", "978-0596516178")
d = DVD.new("John Jer", 1935, "A Midsummer Night’s Dream", 31, 5, 2020, 101781, 145, "Warner Bros. Pictures", "Max Reinhardt", ["James Cagney", "Mickey Rooney", "Olivia de Havilland"])


puts
puts d.m_name
puts "Checked out by " + d.patron
puts "Is the item overdue?"
puts d.isOverDue().to_s
puts 

puts b.m_name
puts "Checked out by " + b.patron
puts "Is the item overdue?"
puts b.isOverDue().to_s
puts

# lambda for adding stuff
add = lambda { |a, b| a + b }
# currying the previous lambda for a simple increment
extend_due_month_by_one = add.curry.call(1)

# For simplicity, ignore cases where extending from December into next year or from 31 of a month with 31 days into a month with less than 31 days
# I.e., I am just playing with lambdas here
puts "Extending the due date of " + b.m_name + " by 1 month from: " + b.due_m.to_s + "/" + b.due_d.to_s + "/" + b.due_y.to_s
b.due_m = extend_due_month_by_one.call(b.due_m)
puts "to: " + b.due_m.to_s + "/" + b.due_d.to_s + "/" + b.due_y.to_s

puts "Is the item overdue now?"
puts b.isOverDue().to_s
puts