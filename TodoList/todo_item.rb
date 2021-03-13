require 'time'

class TodoItem

  # TodoItem.new takes in a name (required), and a due date (not required)
  # A new TodoItem also initializes its status to :open

  # TodoItem should have a name method, and a due method that returns
  # its name and due date respectively. And setters to.

  # There should be done! and not_done! methods that change the status
  # to :closed and :open respectively

  # There should be an open? method that returns if status is :open

  # The overdue? method: an item is overdue if it is open and the due
  # date is earlier than now (i.e. Time.now)

  # BEGIN SOLUTION

  def initialize(name,date = nil)
	@status = :open
    @name = name
    @due = date
  end



  def done!
    @status = :closed
  end

  def not_done!
    @status = :open
  end

  def open?
    if @status == :open
      return true
    else
      return false
    end
  end

  def overdue?
=begin
   date_ = @date.split(",") 
   if date_[0] == "January"
   	month = 1
	end
   if date_[0] == "Febuary"
   	month = 2
	end
   if date_[0] == "March"
   	month = 3
	end
   if date_[0] == "April"
   	month = 4
	end
   if date_[0] == "May"
   	month = 5
	end
   if date_[0] == "June"
   	month = 6
	end
   if date_[0] == "July"
   	month = 7
	end
   if date_[0] == "August"
   	month = 8
	end
   if date_[0] == "September"
   	month = 9
	end
   if date_[0] == "October"
   	month = 10
	end
   if date_[0] == "November"
   	month = 11
    end
   if date_[0] == "December"
   	month = 12
   end
   day = date_[1].tr('th,', '')
   day = date_[1].tr('st,', '')
   day = date_[1].tr('nd,', '')

   year = date_[3]

   total_date = "%s-%s-%s" % [year, month, day]
=end

    if @status == :open and @due < Time.now
      return true
    else
      return false
    end
  end

  attr_accessor :name, :due
end
