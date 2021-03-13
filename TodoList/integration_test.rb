require_relative 'todo_item'
require 'time'
require 'test/unit'
require 'todo_list'

class IntegrationTest < Test::Unit::TestCase

  # Write a single test that simulates a typical sequence of operations
  # Your test must ONLY interact with TodoList, which in turn
  # would use TodoItem as part of its implementation.
  #
  # Have many assert_* statements along the way to verify behavior
  #
  # Your integration test must exercise every method of todo_list
  # (not necessarily every method of todo_item)
  # (also: don't worry about testing Ruby's built-in methods, like
  # to_s and nil? and whatnot - just test the methods you implemented)

  @@DATE = Time.parse '2018-10-31'
  
  def test
  todo = TodoList.new
  todo.add! 'Need to do' 
  assert_equal ['Need to do'], todo.all_open_names
  todo.add! 'Test', @@DATE
  todo.add! 'Test', @@DATE
  expected = [
      { name: 'Test', due: @@DATE, status: :open }]
  assert_equal expected, todo.all_items
  assert_equal 0, todo.num_overdue
  todo.add! 'Test', @@DATE
  assert_equal 1, todo.num_overdue
  todo.done!('Test')
  assert_equal(0, todo.num_overdue)
  todo.add! 'Test', @@DATE
  todo.sort_by_recent!
  expected = [
      { name: 'Test', due: @@DATE, status: :open }]
  assert_equal expected, todo.all_items
  todo.add! 'Test', @@DATE
   todo.add! 'Test2'




end
