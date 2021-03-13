require_relative 'todo_item'
require 'time'
require 'test/unit'

class TodoItemTest < Test::Unit::TestCase
  @@TEST_DATE = Time.parse("January 19, 2038 03:14:07")
  @@TEST_DATE2 = Time.parse("December 13, 2018 09:00:00")

  # DO NOT MODIFY THESE TESTS

  def test_todo_readers
    item = TodoItem.new('Eat.', @@TEST_DATE)
    assert_equal 'Eat.', item.name, 'Todo Item message (@name) should be set'
    assert_equal @@TEST_DATE, item.due, 'Todo Item due date (@due) should be set'
  end

  def test_todo_setters
    item = TodoItem.new('Eat.', @@TEST_DATE)
    item.name = 'Type.'
    item.due = @@TEST_DATE2
    assert_equal 'Type.', item.name, 'Todo Item message (@name) needs a setter'
    assert_equal @@TEST_DATE2, item.due, 'Todo Item due date (@due) needs a setter'
  end

  def test_todo_initial_status
    item = TodoItem.new('Sleep.', @@TEST_DATE)
    assert_true item.open?, 'Status initializes to open'
  end

  def test_done_and_not_done
    item = TodoItem.new('Make.', @@TEST_DATE)
    assert_true item.open?, 'Status initializes to open'
    item.done!
    assert_false item.open?, 'Item is marked as closed'
    item.not_done!
    assert_true item.open?, 'Item is reopened'
  end

  def test_overdue_dates
    long_ago = Time.parse('August 6th, 1991') # a day of infamy
    item =  TodoItem.new('Test.', long_ago)
    assert_true item.overdue?, 'This due date should be waaay overdue'
    item.done!
    assert_false item.overdue?, 'Closed and past is not overdue.'
  end

  def test_overdue_future
    item =  TodoItem.new('Test.', @@TEST_DATE)
    assert_false item.overdue?, 'Future is not overdue.'
  end

  def test_overdue_no_duedate
    item =  TodoItem.new 'Travel.'
    assert_false item.overdue?, 'Closed and past is not overdue.'
  end

end
