require_relative 'todo_item'
require 'time'

class TodoList
  # Initialize with an empty list
  def initialize
    @list = []
#   @status = :open
    @due = nil
    @todoitem = nil

  end

  # Append a new todo list item to the end of the todo list
  # The date field is optional
  # You must write the method signature
  def add!(list_item, due = nil)
#  @list.push(list_item)
    @due = due
    todoitem = TodoItem(list_item, due).new
    @list.push(todoitem)
  end

  # Mark a given item as done, if it has the same name
  # If two items have the same name, mark both as done
  # (Return value is not defined - can be anything)
  def done!(name)
    done = false
    @list.each{ |item| 
	    if item.name == name
		    item.done!
		    done = true
            end
    }
  end
    
#  if @list.todoitem.include? name
#   	list.each{ |item|
#	  if item.name == name
#	    item.done!
#           done = true
#	  end
#		}
#	end
#	return done
#  end

  # Sorts the internal list by due date, the "largest" due date first
  #
  # (Return value is not defined - can be anything)
  def sort_by_recent!
    @list.sort_by {|obj| obj.due}
    return true
  end

  # Returns the number of todo list items in the list that are overdue
  def num_overdue
  count = 0
  @list.each{ |items| 
#    if items.size == 1
#	continue
      if items.overdue?
	count +=1
      end
  }
  return count
  end

  # Make a list of open todo list name
  #
  # Returns an array of strings
  def all_open_names
    open_items = []
    @list.each{ |items|
   items.status == :open
        open_items.push(items.name)
#   end
  }
return open_items
  end

  # Construct a document-oriented structure of the list
  # Return an array of hashes
  # Each hash is indexed by Ruby symbols for:
  #   * name
  #   * due
  #   * status
  def all_items
  hash1 = {}
  @list.each{ |item|
    arr = [item.due, item.status]
    hash[item.name] = arr
  }
  return hash1
  end

  # Return a prettily-formatted string of the current representation
  # * Each item is on a line
  # * First character is a ! if overdue, space if not
  # * Next three characters are [X] if done, [ ] if not
  # * Next is the name
  # * If there's a due date, add "due " and then the due date
  #   note: don't worry about date formatting - just use the to_s
  #   method on the due date. if for some reason the date formats
  #   differently, we won't count it against you
  #
  def pretty_print
  end
end
