require 'test/unit'
require_relative 'todo_list'

class TodoListTest < Test::Unit::TestCase
  @@DAY_1 = Time.parse '2018-10-31' # Past
  @@DAY_2 = Time.parse '2018-11-01' # Past
  @@DAY_3 = Time.parse '2025-12-25' # Future

  # DO NOT MODIFY THESE TESTS

  def test_add
    todo = TodoList.new
    todo.add! 'Be.'
    assert_equal ['Be.'], todo.all_open_names
  end

  def test_add_with_duedate
    todo = TodoList.new
    todo.add! 'Read.', @@DAY_1
    todo.add! 'Write.', @@DAY_2
    expected = [
      { name: 'Read.', due: @@DAY_1, status: :open },
      { name: 'Write.', due: @@DAY_2, status: :open },
    ]
    assert_equal expected, todo.all_items
  end

  def test_num_overdue
    todo = TodoList.new
    assert_equal 0, todo.num_overdue

    todo.add! 'Read.', @@DAY_1    #Past
    assert_equal 1, todo.num_overdue

    todo.add! 'Write.', @@DAY_2   #Past
    assert_equal 2, todo.num_overdue

    todo.add! 'Publish.', @@DAY_3 #Future
    assert_equal 2, todo.num_overdue
  end

  def test_num_overdue_when_done
    todo = TodoList.new
    assert_equal 0, todo.num_overdue

    todo.add! 'Read.', @@DAY_1    #Past, open
    assert_equal 1, todo.num_overdue

    todo.done!('Read.')

    assert_equal(0, todo.num_overdue)
  end

  def test_sort_by_recent
    todo = TodoList.new
    todo.add! 'Read.', @@DAY_1
    todo.add! 'Write.', @@DAY_2

    todo.sort_by_recent!

    expected = [
      { name: 'Write.', due: @@DAY_2, status: :open },
      { name: 'Read.', due: @@DAY_1, status: :open },
    ]
    assert_equal expected, todo.all_items
  end

  def test_all_open_names
    todo = TodoList.new
    todo.add! 'Read.', @@DAY_1
    todo.add! 'Write.', @@DAY_2
  end

  def test_pretty_print
    todo = TodoList.new
    todo.add! 'Eat'
    todo.add! 'Sleep', @@DAY_1
    todo.add! 'Talk', @@DAY_2
    todo.add! 'Shower', @@DAY_3

    todo.done! 'Talk'

    expected = ""
    expected += " [ ] Eat\n"
    expected += "![ ] Sleep due 2018-10-31 00:00:00 -0400\n"
    expected += " [X] Talk due 2018-11-01 00:00:00 -0400\n"
    expected += " [ ] Shower due 2025-12-25 00:00:00 -0500\n"

    assert_equal expected, todo.pretty_print
  end

end
